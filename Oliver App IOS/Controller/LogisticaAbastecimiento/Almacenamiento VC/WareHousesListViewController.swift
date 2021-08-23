//
//  WareHousesListViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 03/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class WareHousesListViewController: UIViewController {
    @IBOutlet weak var tbl: UITableView!
    var purchasedOrderArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var wareHosesKey = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        tbl.register(UINib(nibName: "AlmacenamientoTableViewCell", bundle: nil), forCellReuseIdentifier: "AlmacenamientoTableViewCell")
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
                for item in array {
                    let obj = item as? DataSnapshot
                    if obj?.key != self.wareHosesKey
                    {
                        self.purchasedOrderArray.append(item)
                    }
                }
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
 }
extension WareHousesListViewController : UITabBarDelegate,UITableViewDataSource
{
    
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
 {
            return purchasedOrderArray.count
 }
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AlmacenamientoTableViewCell", for: indexPath) as! AlmacenamientoTableViewCell
    let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
    cell.lbl1.text = obj.childSnapshot(forPath: "warehouse_name").value as? String ?? ""
    let warehouse_destination = obj.childSnapshot(forPath: "warehouse_destination").value as? String ?? ""
    if  warehouse_destination == "products" {
        cell.lbl2.text = "Destino: Productos Terminados"
    }
    if  warehouse_destination == "materials" {
        cell.lbl2.text = "Destino: Materiales o Insumos"
    }
    cell.selectionStyle = .none
    cell.btn.setTitle("SELECCIONAR", for: .normal)
    cell.btn.addTarget(self,action:#selector(buttonAlmacenamiento),for:.touchUpInside)
    cell.btn.tag = indexPath.row
    return cell
    }
    @objc func buttonAlmacenamiento(sender:UIButton) -> Void{
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddTransferirViewController") as! AddTransferirViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.wareHousesKey = wareHosesKey
        nextViewController.imageURL = String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? "")
        nextViewController.matchView = "WareHouses"
        nextViewController.stockValue = obj.childSnapshot(forPath: "product_stock").value as? String ?? ""
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}




