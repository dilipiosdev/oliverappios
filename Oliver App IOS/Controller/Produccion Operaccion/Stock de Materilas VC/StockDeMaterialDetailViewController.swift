//
//  ControldeInventViewController.swift
//  Oliver App IOS
//
//  Created by apple on 08/02/21.
//

import UIKit
import JGProgressHUD
import Firebase

class StockDeMaterialDetailViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl3: UITableView!

    @IBOutlet weak var stockActualView: UIView!
    @IBOutlet weak var categoriaView: UIView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    var wareHosesKey = String()
    var wareHouseName = String()
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
     super.viewDidLoad()
     tbl1.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
    tbl2.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
    tbl3.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
    companyId = companyDetailDict.key
     getProductList()
        
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
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
                self.tbl3.reloadData()
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
    if tableView == tbl1 {
      return  self.purchasedOrderArray.count
    } else if tableView == tbl2{
       return self.purchasedOrderArray.count
    } else {
       return self.purchasedOrderArray.count
    }
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
    
    if tableView == tbl1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
        
        cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
        let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
        cell.lblText1.isHidden = true
        cell.lblText2.isHidden = true
        cell.subViewSetting.isHidden = true
        return cell
    } else if tableView == tbl2 {
        let cell = tbl2.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
                
       cell.lblText.text = String(format: "%@", (obj.childSnapshot(forPath: "product_stock").value as? String ?? ""))
        cell.lblText1.text = "S/ " + String(format: obj.childSnapshot(forPath: "product_price").value as? String ?? "-")
        cell.lblText2.text = "S/ " + String(format: "%.2f", ((Double(String(format: obj.childSnapshot(forPath: "product_price").value as? String ?? "0.00")) ?? 0.00) * (Double(String(format: "%@", (obj.childSnapshot(forPath: "product_stock").value as? String ?? "0.00"))) ?? 0.00)))
        
        cell.imgView.isHidden = true
        cell.selectionStyle = .none
        cell.lblText.textAlignment = .left
        cell.lblText1.textAlignment = .center
        cell.lblText2.textAlignment = .right
        cell.subViewSetting.isHidden = true
        return cell
    } else {
        let cell = tbl3.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
                
       cell.lblText.text = String(format: "%@", (obj.childSnapshot(forPath: "product_stock_manual_count").value as? String ?? "0"))
      
      let productStorck = String(format: "%@", (obj.childSnapshot(forPath: "product_stock").value as? String ?? "0"))
        if (Double(cell.lblText.text ?? "0.00") ?? 0.00) <= 0 {
            cell.lblText1.text = "0"
        } else {
            cell.lblText1.text =  String(format: "%.2f", ((Double(cell.lblText.text ?? "0.00") ?? 0.00) - (Double(productStorck) ?? 0.00)))
        }
        cell.lblText2.text =  String(format: "%@", (obj.childSnapshot(forPath: "product_category").value as? String ?? "-"))
//        if value >= 10  {
//            cell.lblText2.text = "A"
//        } else if value >= 5 && value <= 9 {
//            cell.lblText2.text = "B"
//        } else if (value < 4){
//            cell.lblText2.text = "C"
//        }
       
     cell.buttonSetting.tag = indexPath.row
     cell.buttonSetting.addTarget(self,action:#selector(buttonSetting),for:.touchUpInside)
      cell.lblText.textAlignment = .left
      cell.lblText2.textAlignment = .center
      cell.imgView.isHidden = true
      cell.selectionStyle = .none
      return cell
    }
  }
    @objc func buttonSetting(sender:UIButton) -> Void{
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddStockDeMaterialDetailViewController") as! AddStockDeMaterialDetailViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.productName = String(format: obj.childSnapshot(forPath: "product_name").value as? String ?? "0.00")
        nextViewController.imageURL = String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? "")
        nextViewController.obj = obj
        nextViewController.wareHosesKey = wareHosesKey
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth:CGFloat = scrollView.frame.width
            let current:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        if current == 0 {
            lbl1.isHidden = false
            lbl2.isHidden = true
            lbl3.isHidden = true

        } else  if current == 1 {
            lbl1.isHidden = true
            lbl2.isHidden = false
            lbl3.isHidden = true
        } else {
            lbl1.isHidden = true
            lbl2.isHidden = true
            lbl3.isHidden = false
        }
    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    @IBAction func btn1(_ sender: Any) {
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
        scrollToPage(page: 0, animated: true)

    }
  
    @IBAction func btn2(_ sender: Any) {
        lbl1.isHidden = true
        lbl2.isHidden = false
        lbl3.isHidden = true
        scrollToPage(page: 1, animated: true)

    }
    @IBAction func btn3(_ sender: Any) {
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = false
        scrollToPage(page: 2, animated: true)
    }
}
