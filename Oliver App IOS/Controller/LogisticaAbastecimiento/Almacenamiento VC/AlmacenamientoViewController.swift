//
//  AlmacenamientoViewController.swift
//  Oliver App IOS
//
//  Created by apple on 08/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class AlmacenamientoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     var companyDetailDict = DataSnapshot()
     var companyId = String()
     var purchasedOrderArray = Array<Any>()
     let calender = Calendar.current
     let date = Date()
    
    @IBOutlet weak var tbl: UITableView!
    override func viewDidLoad() {
        companyId = companyDetailDict.key
        super.viewDidLoad()
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
        cell.btn.addTarget(self,action:#selector(buttonAlmacenamiento),for:.touchUpInside)
        cell.btn.tag = indexPath.row
        return cell
    }
    @objc func buttonAlmacenamiento(sender:UIButton) -> Void{
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MisDetailsViewController") as! MisDetailsViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.wareHouseName = obj.childSnapshot(forPath: "warehouse_name").value as? String ?? ""
        nextViewController.wareHosesKey = obj.key
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func buttonAddAlmacenamiento(_ sender: UIButton) {
       // let obj = self.purchasedOrderArray[ (self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AlmacenamientoAddVC") as! AlmacenamientoAddVC
        nextViewController.companyDetailDict = companyDetailDict
       // nextViewController.warehousesKey = obj.key
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}
