//
//  CustomerListViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 08/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class CustomerListViewController: UIViewController {
    var userListArray = Array<Any>()
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyID = String()
    var customer_define = String()
    var customerType = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "DestinatarioTableViewCell", bundle: nil), forCellReuseIdentifier: "DestinatarioTableViewCell")
        companyID = companyDetailDict.key
        getCustomerList()
    }
    
    
    /************************GET CUSTOMER List ************************************/
    func getCustomerList() -> Void {
        self.userListArray.removeAll()
        self.tbl.reloadData()
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyID)").child("Customers")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.userListArray.removeAll()
                for item  in array {
                    let dict = item as! DataSnapshot
                    let uid = dict.childSnapshot(forPath: "customer_type").value as? String ?? ""
                    self.userListArray.append(dict)
                }
                hud.dismiss()
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
    @IBAction func buttonAddCustomer(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCustomerViewController") as! AddCustomerViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.customer_define = customer_define
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
}


//MARK:- TableView Methods
extension CustomerListViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DestinatarioTableViewCell", for: indexPath) as! DestinatarioTableViewCell
        let obj = self.userListArray[indexPath.row] as! DataSnapshot
        cell.lblName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
        cell.lblNumber.text = String(format: "Telefono: %@",obj.childSnapshot(forPath: "customer_phone").value as? String ?? "")
        cell.lblEmail.text = String(format: "Correo: %@",obj.childSnapshot(forPath: "customer_email").value as? String ?? "")
        cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
        cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
        cell.selectionStyle = .none
        cell.buttonDefinir.isHidden = true
        cell.buttonDefiniarConst.constant = 0
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if customerType == "AddCustomerSchedule" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerSchedulesVC") as! CustomerSchedulesVC
            nextViewController.companyDetailDict = companyDetailDict
            nextViewController.modalPresentationStyle = .overFullScreen
            let obj = self.userListArray[indexPath.row] as! DataSnapshot
            nextViewController.customerDetailDict = obj
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
}
