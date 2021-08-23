//
//  PlaneamientoDeLaDemsndaDetails1VC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 21/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class PlaneamientoDeLaDemsndaDetails1VC: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var productID = String()
    var monthArray = Array<Any>()
    @IBOutlet weak var tbl3: UITableView!
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    
    var m1Value = Int()
    var m2Value = Int()
    var m3Value = Int()
    var m4Value = Int()
    var m5Value = Int()
    var m6Value = Int()
    var m7Value = Int()
    var m8Value = Int()
    var m9Value = Int()
    var m10Value = Int()
    var m11Value = Int()
    var m12Value = Int()
    var dic11 = Dictionary<String,Any>()
    @IBOutlet weak var imgProductImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    
    var uniDasValue = Double()
    var dineroValue = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        monthArray = ["ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"]
        companyId = companyDetailDict.key
        tbl1.register(UINib(nibName: "PlaneanientoDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaneanientoDetailsTableViewCell")
        tbl2.register(UINib(nibName: "PlaneanientoDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaneanientoDetailsTableViewCell")
        tbl3.register(UINib(nibName: "BottomTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomTableViewCell")
        
        getProductList()
        
    }
    
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Products").child(productID)
        userRef.observe(.value) { [self] (snapshot) in
            if let dic = snapshot.value as? Dictionary<String,Any>
            {
                self.dic11 = dic
                self.lblProductName.text = String(format: "%@",self.dic11["product_name"] as? String ?? "")
                let url = NSURL(string: String(format: "%@", self.dic11["product_image"] as? String ?? ""))
                let image:UIImage = UIImage(named: "back")!
                self.imgProductImage.af.setImage(withURL: url! as URL, placeholderImage: image)

                hud.dismiss()
                self.tbl1.reloadData()
                self.tbl2.reloadData()
                let components = self.calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.date)
                
                for i in 0 ..< 12 {
                    let quintityKey = String(format: "%d%dquantity",components.year! - 1, i + 1)
                    let quintityKey1 = String(format: "%d%dquantity_projection",components.year! - 1, i + 1)
                    self.uniDasValue = self.uniDasValue + (self.dic11[quintityKey] as? Double ?? 0)
                    
                    self.dineroValue =  self.dineroValue + (self.dic11[quintityKey1] as? Double ?? 0)
                }
                self.tbl3.reloadData()
                
            }
            else
            {
                hud.dismiss()
                
            }
        }
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PlaneamientoDeLaDemsndaDetails1VC : UITabBarDelegate,UITableViewDataSource
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tbl1
        {
            return monthArray.count
        } else if tableView == tbl2 {
            return monthArray.count
        } else if tableView == tbl3 {
            return 2
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl1
        {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "PlaneanientoDetailsTableViewCell", for: indexPath) as! PlaneanientoDetailsTableViewCell
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            cell.lbl1.text = String(format: "%@", monthArray[indexPath.row] as? String ?? 0)

            let quintityKey = String(format: "%d%dquantity",components.year! - 1,indexPath.row + 1)
            let quintityValueStr = String(format: "%d", dic11[quintityKey] as? Int ?? 0)
            cell.lbl2.text = String(format: "%@", quintityValueStr)
            
            
            let sales_projectionKey = String(format: "%d%dsales_projection",components.year! - 1,indexPath.row + 1)
            let sales_projectionKeyStr = String(format: "%d", dic11[sales_projectionKey] as? Int ?? 0)
            if ((Int(sales_projectionKeyStr) ?? 0) > 0) {
                cell.lbl3.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                cell.lbl3.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
            cell.lbl3.text = String(format: "%@", sales_projectionKeyStr)
            cell.lbl4.text = "-"

            return cell
        } else if tableView == tbl2 {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "PlaneanientoDetailsTableViewCell", for: indexPath) as! PlaneanientoDetailsTableViewCell
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            cell.lbl1.text = String(format: "%@", monthArray[indexPath.row] as? String ?? 0)
            let quintityKey = String(format: "%d%dsales",components.year! - 1,indexPath.row + 1)
            let quintityValueStr = String(format: "%d", dic11[quintityKey] as? Int ?? 0)
            cell.lbl2.text = String(format: "%@", quintityValueStr)
            
            let sales_projectionKey = String(format: "%d%dsales_projection",components.year! - 1,indexPath.row + 1)
            let sales_projectionKeyStr = String(format: "%d", dic11[sales_projectionKey] as? Int ?? 0)
            if ((Int(sales_projectionKeyStr) ?? 0) > 0) {
                cell.lbl3.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                cell.lbl3.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
            cell.lbl3.text = String(format: "%@", sales_projectionKeyStr)
            let value1 = ((Double(cell.lbl2.text ?? "0.00") ?? 0.00) / (Double(cell.lbl3.text ?? "0.00") ?? 0.00))
            cell.lbl4.text = String(format: "%.2f", (value1 * 10))
            return cell
        } else {
            let cell = tbl3.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
            cell.imgView.image = UIImage(named: "settingFichas")
            
            let value1 = Double(uniDasValue/dineroValue)
            let value2 = (value1 - 1) * 100
            if indexPath.row == 0 {
                cell.totalComutationLbl.text = String(format: "%.2f%@", value2,"%")
            } else {
                cell.totalComutationLbl.text = String(format: "%.2f", value1)
            }
          
            return cell
        }
    }
  
}


