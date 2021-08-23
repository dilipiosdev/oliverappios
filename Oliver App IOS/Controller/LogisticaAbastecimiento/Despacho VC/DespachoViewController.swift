//
//  ProcesamientoViewController.swift
//  Oliver App IOS
//
//  Created by apple on 12/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class DespachoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
     var purchasedOrderArray = Array<Any>()
     let calender = Calendar.current
     let date = Date()
    
    
 override func viewDidLoad() {
     super.viewDidLoad()
     tbl.register(UINib(nibName: "DespachoTableViewCell", bundle: nil), forCellReuseIdentifier: "DespachoTableViewCell")
    companyId = companyDetailDict.key
    getProductList()
 }
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Dispatches")
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
    return self.purchasedOrderArray.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "DespachoTableViewCell", for: indexPath) as! DespachoTableViewCell
      let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot

     cell.lbl1.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
    let state = obj.childSnapshot(forPath: "dispatch_state").value as? String ?? ""
    if (state == "pending") {
        cell.lbl1.text = "Despacho"
    }
    else if (state == "ready")
    {
        cell.lbl1.text = "Entregado"
    }
    let customerID = obj.childSnapshot(forPath: "dispatch_customer_id").value as? String ?? ""
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
    
    
    cell.lbl3.text = obj.childSnapshot(forPath: "dispatch_address").value as? String ?? ""
    cell.lbl4.text = obj.childSnapshot(forPath: "dispatch_shift").value as? String ?? ""
    cell.buttonSetting.addTarget(self,action:#selector(buttonEdit),for:.touchUpInside)
    
     return cell
 }
    @objc func buttonEdit(sender:UIButton) -> Void{
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateDispatchViewController") as! UpdateDispatchViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.dispachKey = obj.key
        
        self.present(nextViewController, animated: true, completion: nil)
        
    }
}
