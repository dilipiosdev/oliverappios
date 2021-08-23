//
//  ProcesamientoViewController.swift
//  Oliver App IOS
//
//  Created by apple on 12/02/21.
//

import UIKit
import JGProgressHUD
import Firebase



class ProcesamientoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tbl: UITableView!
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.register(UINib(nibName: "ProcesamientoTableViewCell", bundle: nil), forCellReuseIdentifier: "ProcesamientoTableViewCell")
        companyId = companyDetailDict.key
        getProductList()
    }
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Orders Processing")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedOrderArray = array
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasedOrderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProcesamientoTableViewCell", for: indexPath) as! ProcesamientoTableViewCell
       
        let obj = self.purchasedOrderArray[ indexPath.row] as! DataSnapshot
        cell.lbl1.text = obj.childSnapshot(forPath: "order_processing_state").value as? String ?? ""
        let customerID = obj.childSnapshot(forPath: "order_processing_customer_id").value as? String ?? ""
        if customerID.count > 0
        {
            
            DispatchQueue.main.async {
               let userRef = Database.database().reference().child("My Companies/\(self.companyId)").child("Customers").child(customerID)
                 userRef.observeSingleEvent(of: .value) { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String,Any>
                {
                    cell.lbl2.text = dict["customer_name"] as? String ?? ""
                }
                else
                {
                }
                }
             }
        }
        cell.lbl3.text = obj.childSnapshot(forPath: "operation_date").value as? String ?? ""
        cell.lbl4.text = obj.childSnapshot(forPath: "order_processing_total_amount").value as? String ?? ""

        cell.selectionStyle = .none
        cell.buttonSetting.addTarget(self,action:#selector(buttonEdit),for:.touchUpInside)
        return cell
        
    }
    @objc func buttonEdit(sender:UIButton) -> Void{
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateProcesamientoViewController") as! UpdateProcesamientoViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.ordersProcessingKey = obj.key
        
        self.present(nextViewController, animated: true, completion: nil)
        
    }
}
