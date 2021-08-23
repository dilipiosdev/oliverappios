//
//  FichasViewController.swift
//  Oliver App IOS
//
//  Created by apple on 04/02/21.
//

import UIKit
import JGProgressHUD
import Firebase

class FichasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView : UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        tableView.register(UINib(nibName: "FichasTableViewCell", bundle: nil), forCellReuseIdentifier:  "FichasTableViewCell")
        getProductList()
    }
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Products")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedOrderArray = array
                self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FichasTableViewCell", for: indexPath) as! FichasTableViewCell
       let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
       cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
       let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
       let image:UIImage = UIImage(named: "back")!
       cell.imgLeft.af.setImage(withURL: url! as URL, placeholderImage: image)
       
       cell.selectionStyle = .none
       cell.buttonSetting.addTarget(self,action:#selector(buttonSetting),for:.touchUpInside)
        cell.buttonSetting.tag = indexPath.row
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    }
    @objc func buttonSetting(sender:UIButton) -> Void{
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FichasDetailsViewController") as! FichasDetailsViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.objProduct = obj
        nextViewController.objProductKey = obj.key
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
