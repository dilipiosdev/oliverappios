//
//  CosteoViewController.swift
//  Oliver App IOS
//
//  Created by apple on 04/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class CosteoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tbl: UITableView!
    var purchasedOrderArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    let calender = Calendar.current
    let date = Date()
    @IBOutlet weak var labelTotalCost: UILabel!
    var totalAmountBottom = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        tbl.register(UINib(nibName: "CosteoTableViewCell", bundle: nil), forCellReuseIdentifier:  "CosteoTableViewCell")
        getProductList()
    }
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Products")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedOrderArray = array
                for i in 0 ..< self.purchasedOrderArray.count-1 {
                    let obj = self.purchasedOrderArray[i] as! DataSnapshot
                    let array = obj.childSnapshot(forPath: "Production Items").children.allObjects as? Array<Any> ?? nil
                   if array?.count ?? 0 > 0 {
                    for j in 0 ..< ((array?.count ?? 0) - 1) {
                        let item1 = array?[j] as? DataSnapshot
                        let item_price = item1?.childSnapshot(forPath: "item_price").value as? String ?? ""
                        let item_stock = item1?.childSnapshot(forPath: "item_quantity").value as?
                        String ?? ""
                        self.totalAmountBottom = self.totalAmountBottom + Int((Double(item_price) ?? 0.0) * (Double(item_stock) ?? 0.00))
                      }
                    }
                }
                self.labelTotalCost.text = String(format: "COSTO TOTAL: %.2f", Double(self.totalAmountBottom))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CosteoTableViewCell", for: indexPath) as! CosteoTableViewCell
       let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
       cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
        cell.subViewSetting.isHidden = true
        var totlaValue = 0.00
        let array = obj.childSnapshot(forPath: "Production Items").children.allObjects as? Array<Any> ?? nil
        if array?.count ?? 0 > 0
        {
            for index in 0 ..< (array?.count ?? 0) {
                let item1 = array?[index] as? DataSnapshot
                let item_price = item1?.childSnapshot(forPath: "item_price").value as? String ?? ""
                let item_stock = item1?.childSnapshot(forPath: "item_quantity").value as?
                String ?? ""
                totlaValue = totlaValue + (Double(item_price) ?? 0.0) * (Double(item_stock) ?? 0.00)
             }
        }
        cell.lblItemPrice.text = String(format: "%.2f", totlaValue)

       let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
       let image:UIImage = UIImage(named: "back")!
       cell.imgLeft.af.setImage(withURL: url! as URL, placeholderImage: image)
       cell.selectionStyle = .none
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
    }
    @objc func buttonSetting(sender:UIButton) -> Void{
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddOrdenesViewController") as! AddOrdenesViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        self.present(nextViewController, animated: true, completion: nil)
    }
}



