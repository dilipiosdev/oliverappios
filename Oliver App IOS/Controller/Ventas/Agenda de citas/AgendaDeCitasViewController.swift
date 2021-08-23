//
//  AgendaDeCitasViewController.swift
//  Oliver App IOS
//
//  Created by apple on 06/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class AgendaDeCitasViewController: UIViewController {
    var customerSchedulesListArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    
    @IBOutlet weak var tbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "AgendaTableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaTableViewCell")
        companyId = companyDetailDict.key
        getCustomerList()
    }
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonAgendar(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerListViewController") as! CustomerListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.customerType = "AddCustomerSchedule"
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func getCustomerList() -> Void {
        self.customerSchedulesListArray.removeAll()
        self.tbl.reloadData()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyId)").child("Customer Schedules")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.customerSchedulesListArray.removeAll()
                for item  in array {
                    let dict = item as! DataSnapshot
                    self.customerSchedulesListArray.append(dict)
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
    }
    
    
    
}
//MARK:- TableView Methods
extension AgendaDeCitasViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerSchedulesListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as! AgendaTableViewCell
        
        let obj = self.customerSchedulesListArray[self.customerSchedulesListArray.count - (indexPath.row + 1)] as! DataSnapshot
        cell.lblText.text = obj.childSnapshot(forPath: "date").value as? String ?? ""
        cell.lblClientName.text = String(format: "%@",obj.childSnapshot(forPath: "customer_name").value as? String ?? "")
        cell.lblTime.text = String(format: "%@",obj.childSnapshot(forPath: "time").value as? String ?? "")
        
        cell.selectionStyle = .none
        return cell
        
    }
    
}
