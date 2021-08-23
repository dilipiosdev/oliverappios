//
//  ControldeInventViewController.swift
//  Oliver App IOS
//
//  Created by apple on 08/02/21.
//

import UIKit
import JGProgressHUD
import Firebase

class StockDeMaterialViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
 @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    
    
 override func viewDidLoad() {
     super.viewDidLoad()
    companyId = companyDetailDict.key
    tbl.register(UINib(nibName: "StockDeMaterialsTableViewCell", bundle: nil), forCellReuseIdentifier: "StockDeMaterialsTableViewCell")
    getProductList()

 }
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Warehouses")
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
      let cell = tableView.dequeueReusableCell(withIdentifier: "StockDeMaterialsTableViewCell", for: indexPath) as! StockDeMaterialsTableViewCell
    let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
    cell.lblComapanyName.text = obj.childSnapshot(forPath: "warehouse_name").value as? String ?? ""
    let warehouse_destination = obj.childSnapshot(forPath: "warehouse_destination").value as? String ?? ""
    if  warehouse_destination == "products" {
        cell.lblDes.text = "Destino: Productos Terminados"
    }
    if  warehouse_destination == "materials" {
        cell.lblDes.text = "Destino: Materiales o Insumos"
    }
    cell.selectionStyle = .none
    cell.btnGestionar.addTarget(self,action:#selector(buttonAlmacenamiento),for:.touchUpInside)
    cell.btnGestionar.tag = indexPath.row
    cell.btnGestionar.setTitle("SELECCIONAR", for: .normal)
    return cell
}
@objc func buttonAlmacenamiento(sender:UIButton) -> Void{
    let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
    let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "StockDeMaterialDetailViewController") as! StockDeMaterialDetailViewController
    nextViewController.companyDetailDict = companyDetailDict
    nextViewController.wareHouseName = obj.childSnapshot(forPath: "warehouse_name").value as? String ?? ""
    nextViewController.wareHosesKey = obj.key
    self.navigationController?.pushViewController(nextViewController, animated: true)
}

}

