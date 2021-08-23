//
//  BusquedaViewController.swift
//  Oliver App IOS
//
//  Created by apple on 08/02/21.
//

import UIKit
import JGProgressHUD
import Firebase

class BusquedaViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
 @IBOutlet weak var tbl: UITableView!
 var companyDetailDict = DataSnapshot()
 var purchasedOrderArray = Array<Any>()
 var companyId = String()
 override func viewDidLoad() {
     super.viewDidLoad()
    tbl.register(UINib(nibName: "BusquedaTableViewCell", bundle: nil), forCellReuseIdentifier: "BusquedaTableViewCell")
    companyId = companyDetailDict.key
    getPurchasedOrder()
 }
 
    
    func getPurchasedOrder() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Purchased Items")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
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
      let cell = tableView.dequeueReusableCell(withIdentifier: "BusquedaTableViewCell", for: indexPath) as! BusquedaTableViewCell
    let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
    cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
    cell.lblTime.text = "S/ " + (obj.childSnapshot(forPath: "product_price").value as? String ?? "")
    let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
    let image:UIImage = UIImage(named: "back")!
    cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
    cell.selectionStyle = .none
     return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BusquedaDetailViewController") as! BusquedaDetailViewController
        nextViewController.companyDetailDict = companyDetailDict
        let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
        nextViewController.item_id = obj.key
        nextViewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
 }
