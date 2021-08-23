//
//  BusquedaDetailViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 24/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class BusquedaDetailViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var purchasedOrderArray = Array<Any>()
    var companyId = String()
    var item_id = String()

    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl3: UITableView!
    @IBOutlet weak var tbl4: UITableView!
    @IBOutlet weak var lblPrecioMain: UILabel!
    
    @IBOutlet weak var lblCalidadMain: UILabel!
    
    @IBOutlet weak var lblTimpeoMain: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl1.register(UINib(nibName: "PrecioTableViewCell", bundle: nil), forCellReuseIdentifier: "PrecioTableViewCell")
        tbl2.register(UINib(nibName: "PrecioTableViewCell", bundle: nil), forCellReuseIdentifier: "PrecioTableViewCell")
        tbl3.register(UINib(nibName: "PrecioTableViewCell", bundle: nil), forCellReuseIdentifier: "PrecioTableViewCell")
        tbl4.register(UINib(nibName: "PrecioTableViewCell", bundle: nil), forCellReuseIdentifier: "PrecioTableViewCell")
        companyId = companyDetailDict.key
        getPurchasedOrder()
        getPurchasedOrderList()
    }
    
  func getPurchasedOrder() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Purchased Items").child(item_id).child("Evaluation")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
          if let dict = snapshot.value as? Dictionary<String,Any>
          {
            self.lblPrecioMain.text = String(format: "%d", dict["price_weight"] as? Int ?? 0) + "%"
            self.lblCalidadMain.text = String(format: "%d", dict["quality_weight"] as? Int ?? 0) + "%"
            self.lblTimpeoMain.text = String(format: "%d",dict["time_weight"] as? Int ?? 0) + "%"
            hud.dismiss()

          }
          else
          {
            hud.dismiss()

          }
        }
    }
    func getPurchasedOrderList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Suppliers")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.tbl1.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    func getPurchasedOrder1() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Suppliers")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedOrderArray = array
                self.tbl1.reloadData()
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
    
}
extension BusquedaDetailViewController : UITabBarDelegate,UITableViewDataSource
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tbl1
        {
            return self.purchasedOrderArray.count
        } else if tableView == tbl2 {
           return self.purchasedOrderArray.count
        } else if tableView == tbl3 {
           return self.purchasedOrderArray.count
        } else if tableView == tbl4 {
           return self.purchasedOrderArray.count
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl1
        {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "PrecioTableViewCell", for: indexPath) as! PrecioTableViewCell
            let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
            cell.lbl1.text = obj.childSnapshot(forPath: "supplier_name").value as? String ?? ""
            cell.lbl2.text = obj.childSnapshot(forPath: "supplier_name").value as? String ?? ""
            cell.lbl3.text = obj.childSnapshot(forPath: "supplier_name").value as? String ?? ""
            cell.lbl4.text = obj.childSnapshot(forPath: "supplier_name").value as? String ?? ""
           return cell
        } else if tableView == tbl2 {
            let cell = tbl2.dequeueReusableCell(withIdentifier: "PrecioTableViewCell", for: indexPath) as! PrecioTableViewCell
           return cell
        } else if tableView == tbl3 {
            let cell = tbl3.dequeueReusableCell(withIdentifier: "PrecioTableViewCell", for: indexPath) as! PrecioTableViewCell
           return cell
        } else {
            let cell = tbl4.dequeueReusableCell(withIdentifier: "PrecioTableViewCell", for: indexPath) as! PrecioTableViewCell
           return cell
        }
    }
}


