//
//  MisVendedoresViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 06/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class MisVendedoresViewController: UIViewController {
    var customerListArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    
    @IBOutlet weak var tbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "DestinatarioTableViewCell", bundle: nil), forCellReuseIdentifier: "DestinatarioTableViewCell")
        companyId = companyDetailDict.key
        getCustomerList()
    }
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCustomerList() -> Void {
        self.customerListArray.removeAll()
        self.tbl.reloadData()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyId)").child("Sellers")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.customerListArray.removeAll()
                self.customerListArray = array
                hud.dismiss()
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    @IBAction func buttonAddseller(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddSellerViewController") as! AddSellerViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}
//MARK:- TableView Methods
extension MisVendedoresViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "DestinatarioTableViewCell", for: indexPath) as! DestinatarioTableViewCell
            let obj = self.customerListArray[indexPath.row] as! DataSnapshot
            cell.lblName.text = obj.childSnapshot(forPath: "seller_name").value as? String ?? ""
            cell.lblNumber.text = String(format: "%@",obj.childSnapshot(forPath: "seller_phone").value as? String ?? "")
            cell.lblEmail.text = String(format: "%@",obj.childSnapshot(forPath: "seller_email").value as? String ?? "")
            cell.lblTipo.text = String(format: "%@",obj.childSnapshot(forPath: "seller_document_number").value as? String ?? "")
            cell.selectionStyle = .none
            cell.buttonDefinir.isHidden = true
            cell.buttonDefiniarConst.constant = 0
        
            return cell
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
   
}
