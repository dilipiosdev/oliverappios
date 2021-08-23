//
//  ControldeInventDetailViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 01/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class ControldeInventDetailViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl3: UITableView!
    var wareHosesKey = String()
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        tbl1.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        tbl2.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        tbl3.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        getProductList()
        lbl3.isHidden = true
        lbl2.isHidden = true
        lbl1.isHidden = false

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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
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
    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView1.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView1.scrollRectToVisible(frame, animated: animated)
    }
}
extension ControldeInventDetailViewController : UITabBarDelegate,UITableViewDataSource
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tbl1
        {
          return purchasedOrderArray.count
        } else  if tableView == tbl2 {
            return purchasedOrderArray.count
        } else {
            return purchasedOrderArray.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl1
        {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
           cell.lblText.text = ""
           cell.lblText1.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
           cell.lblText2.text = ""
           let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
           let image:UIImage = UIImage(named: "back")!
           cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
           cell.selectionStyle = .none
           cell.subViewSetting.isHidden = true
            return cell
        } else if tableView == tbl2 {
            let cell = tbl2.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
                    
           cell.lblText.text = String(format: "%@", (obj.childSnapshot(forPath: "product_stock").value as? String ?? ""))
            cell.lblText1.text = "S/ " + String(format: obj.childSnapshot(forPath: "product_price").value as? String ?? "-")
            cell.imgView.isHidden = true
           cell.selectionStyle = .none
            cell.lblText2.text = "S/ " + String(format: "%.2f", ((Double(String(format: obj.childSnapshot(forPath: "product_price").value as? String ?? "0.00")) ?? 0.00) * (Double(String(format: "%@", (obj.childSnapshot(forPath: "product_stock").value as? String ?? "0.00"))) ?? 0.00)))
            cell.lblText.textAlignment = .left
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
                cell.lblText2.text = "S/ " + String(format: "%.2f", ((Double(String(format: obj.childSnapshot(forPath: "product_price").value as? String ?? "0.00")) ?? 0.00) * abs((Double(cell.lblText1.text ?? "0.00") ?? 0.00))))
            }
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - sender.tag] as! DataSnapshot
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateControlFisicoVC") as! UpdateControlFisicoVC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.productName = String(format: obj.childSnapshot(forPath: "product_name").value as? String ?? "0.00")
        nextViewController.imageURL = String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? "")
        nextViewController.wareHosesKey = wareHosesKey
        nextViewController.companyUpdateKey = obj.key

        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}



