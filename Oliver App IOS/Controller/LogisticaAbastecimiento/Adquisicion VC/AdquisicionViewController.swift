//
//  AdquisicionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 07/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AdquisicionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 @IBOutlet weak var tbl: UITableView!
var companyDetailDict = DataSnapshot()
var companyId = String()

 var purchasedOrderArray = Array<Any>()
 override func viewDidLoad() {
     super.viewDidLoad()
    companyId = companyDetailDict.key
    tbl.register(UINib(nibName: "AdquisicionTableViewCell", bundle: nil), forCellReuseIdentifier: "AdquisicionTableViewCell")
    getPurchasedOrder()
 }
    
    func getPurchasedOrder() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Purchased Orders")
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
    @IBAction func buttonRegister(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddRegisterAdquisicionVC") as! AddRegisterAdquisicionVC
        nextViewController.companyDetailDict = companyDetailDict
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
 @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
}
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.purchasedOrderArray.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "AdquisicionTableViewCell", for: indexPath) as! AdquisicionTableViewCell
     let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
    
    let status =  obj.childSnapshot(forPath: "purchase_order_state").value as? String ?? ""
    var statusStr = String()
    if status == "pending" {
        statusStr = "Enviado"
    } else  if status == "ready" {
        statusStr = "Entregado"
    } else  if status == "ready_delayed" {
        statusStr = "Entregado con Retraso"
    } else  if status == "ready_delayed" {
        statusStr = "Devuelto"
    } else  if status == "supplier_rejected" {
        statusStr = "Rechazado por Proveedor"
    } else if status == "canceled" {
        statusStr = "Cancelado"
    } else if status == "returned" {
        statusStr = "Devuelto"
    }
    
    
    
    let supplierID = obj.childSnapshot(forPath: "purchase_order_supplier_id").value as? String ?? ""
    if supplierID.count > 0
    {
        DispatchQueue.main.async {
        let userRef = Database.database().reference().child("My Companies/\(self.companyId)").child("My Suppliers").child(supplierID)
          userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any>
            {
                cell.lbl2.text = dict["supplier_name"] as? String ?? ""
            }
            else
            {
            }
          }
         }
    }
     cell.lbl1.text = statusStr
     cell.lbl3.text = obj.childSnapshot(forPath: "operation_date").value as? String ?? ""
     cell.lbl4.text = obj.childSnapshot(forPath: "purchase_order_total_amount").value as? String ?? ""
    cell.selectionStyle = .none
    cell.buttonSetting.addTarget(self,action:#selector(buttonSetting),for:.touchUpInside)
    cell.buttonSetting.tag = indexPath.row
     return cell
     
 }


@objc func buttonSetting(sender:UIButton) -> Void{
    let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddAdquisicionUpdateValueVC") as! AddAdquisicionUpdateValueVC
    nextViewController.companyDetailDict = companyDetailDict
    nextViewController.modalPresentationStyle = .overFullScreen
    let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
    nextViewController.purchaseKey = obj.key

    self.present(nextViewController, animated: true, completion: nil)
}

}
