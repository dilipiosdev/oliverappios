//
//  ControldeInventViewController.swift
//  Oliver App IOS
//
//  Created by apple on 08/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class ControldeInventViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
 @IBOutlet weak var tbl: UITableView!
var purchasedOrderArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
 override func viewDidLoad() {
     super.viewDidLoad()
    companyId = companyDetailDict.key
     tbl.register(UINib(nibName: "ControldeInventariosTableViewCell", bundle: nil), forCellReuseIdentifier: "ControldeInventariosTableViewCell")
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
    
    @IBAction func buttonRegister(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AlmacenamientoAddVC") as! AlmacenamientoAddVC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasedOrderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ControldeInventariosTableViewCell", for: indexPath) as! ControldeInventariosTableViewCell
        let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
        cell.lbl1.text = obj.childSnapshot(forPath: "warehouse_name").value as? String ?? ""
        let warehouse_destination = obj.childSnapshot(forPath: "warehouse_destination").value as? String ?? ""
        if  warehouse_destination == "products" {
            cell.lbl2.text = "Destino: Productos Terminados"
        }
        if  warehouse_destination == "materials" {
            cell.lbl2.text = "Destino: Materiales o Insumos"
        }
        cell.selectionStyle = .none
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self,action:#selector(buttonControldeInventDetail),for:.touchUpInside)
        return cell
    }
    @objc func buttonControldeInventDetail(sender:UIButton) -> Void{
        
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ControldeInventDetailViewController") as! ControldeInventDetailViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.wareHosesKey = obj.key
        nextViewController.modalPresentationStyle = .overFullScreen
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
