//
//  MisDetailsViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 26/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class MisDetailsViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    let calender = Calendar.current
    let date = Date()
    var wareHosesKey = String()
    var wareHouseName = String()
    override func viewDidLoad() {
        companyId = companyDetailDict.key
        super.viewDidLoad()
        tbl1.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        tbl2.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        getProductList()
    }

    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Warehouses").child(wareHosesKey).child("Products")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedOrderArray = array
                self.tbl1.reloadData()
                self.tbl2.reloadData()
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
    @IBAction func buttonAddMis(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddMisExistenciasViewController") as! AddMisExistenciasViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.wareHousesKey = wareHosesKey
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    
}

extension MisDetailsViewController : UITabBarDelegate,UITableViewDataSource
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tbl1
        {
          return purchasedOrderArray.count
        } else {
            return purchasedOrderArray.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl1
        {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
           let obj = self.purchasedOrderArray[(purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
           cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
           cell.lblText1.text = obj.childSnapshot(forPath: "product_stock").value as? String ?? ""
           let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
           let image:UIImage = UIImage(named: "back")!
           cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
           cell.selectionStyle = .none
           cell.buttonSetting.addTarget(self,action:#selector(buttonSetting1),for:.touchUpInside)
           cell.lblText2.text = "-"
            DispatchQueue.main.async {
                let userRef = Database.database().reference().child("My Companies/\(self.companyId)").child("My Products").child(obj.key)
            userRef.observe(.value) { (snapshot) in
                if let dic = snapshot.value as? Dictionary<String,Any>
                {
                    cell.lblText2.text = String(format: "%@",dic["product_stock"] as? String ?? "")
                }
               }
            }
            cell.buttonSetting.tag = indexPath.row
            return cell
        } else {
            let cell = tbl2.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
          
           cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
          cell.lblText1.text = obj.childSnapshot(forPath: "product_stock").value as? String ?? ""
           let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
           let image:UIImage = UIImage(named: "back")!
           cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
           cell.selectionStyle = .none
           cell.buttonSetting.addTarget(self,action:#selector(buttonSetting2),for:.touchUpInside)
           cell.lblText2.text = "-"
            DispatchQueue.main.async {

                let userRef = Database.database().reference().child("My Companies/\(self.companyId)").child("My Products").child(obj.key)
            userRef.observe(.value) { (snapshot) in
                if let dic = snapshot.value as? Dictionary<String,Any>
                {
                    cell.lblText2.text = String(format: "%@",dic["product_stock"] as? String ?? "")
                }
               }
            }
            cell.buttonSetting.tag = indexPath.row
            return cell
        }
    }
    @objc func buttonSetting1(sender:UIButton) -> Void{
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
 
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "KardexViewController") as! KardexViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.productObj = obj
        nextViewController.wareHouseName = wareHouseName
        nextViewController.wareHosesKey = wareHosesKey
        nextViewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func buttonSetting2(sender:UIButton) -> Void{
        
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddTransferirViewController") as! AddTransferirViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.wareHousesKey = wareHosesKey
        nextViewController.imageURL = String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? "")
       
        nextViewController.stockValue = obj.childSnapshot(forPath: "product_stock").value as? String ?? ""
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}



