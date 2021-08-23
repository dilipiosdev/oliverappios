//
//  PlaneanientoViewController.swift
//  Oliver App IOS
//
//  Created by apple on 07/02/21.
//

import UIKit
import JGProgressHUD
import Firebase


class PlaneanientoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   var companyDetailDict = DataSnapshot()
   var companyId = String()
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl3: UITableView!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var scrollView1: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tbl1.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        tbl2.register(UINib(nibName: "ProyectadoTableViewCell", bundle: nil), forCellReuseIdentifier: "ProyectadoTableViewCell")
        tbl3.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
      companyId = companyDetailDict.key
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
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
                
                let components = self.calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.date)
                let quintityKey = String(format: "%d%dquantity",components.year!,components.month!)
                self.purchasedOrderArray = self.purchasedOrderArray.sorted(by: {($0 as AnyObject).childSnapshot(forPath: quintityKey).value as? Double ?? 0.00 > ($1 as AnyObject).childSnapshot(forPath: quintityKey).value as? Double ?? 0.00})
                
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
        if tableView == tbl1
        {
          return purchasedOrderArray.count
        } else if tableView == tbl2 {
            return purchasedOrderArray.count
        } else if tableView == tbl3
        {
          return purchasedOrderArray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl1
        {
             let cell = tbl1.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let quintityKey = String(format: "%d%dquantity",components.year!,components.month!)
           let quintityValueStr =  obj.childSnapshot(forPath: quintityKey).value as? Int ?? 0
            cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
            cell.lblText1.text = String(format: "%d",quintityValueStr)
            cell.lblText2.text = "-"
            let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
            let image:UIImage = UIImage(named: "back")!
            cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
            
            cell.selectionStyle = .none
            cell.buttonSetting.addTarget(self,action:#selector(buttonSetting),for:.touchUpInside)
            cell.buttonSetting.tag = (self.purchasedOrderArray.count - 1)
            
            return cell
        } else if tableView == tbl2 {
            let cell1 = tbl2.dequeueReusableCell(withIdentifier: "ProyectadoTableViewCell", for: indexPath) as! ProyectadoTableViewCell
           let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
           let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
           let quintityKey = String(format: "%d%dquantity_projection",components.year!,components.month!)
          let quintityValueStr =  obj.childSnapshot(forPath: quintityKey).value as? Int ?? 0
            cell1.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
            cell1.lblText1.text = String(format: "%d",quintityValueStr)
           let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
           let image:UIImage = UIImage(named: "back")!
            cell1.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
            cell1.selectionStyle = .none
           return cell1
            
        } else if tableView == tbl3 {
             let cell = tbl1.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let quintityKey = String(format: "%d%dquantity",components.year!,components.month!)
            let quintityKey1 = String(format: "%d%dquantity_projection",components.year!+1,components.month!)

           let quintityValueStr =  obj.childSnapshot(forPath: quintityKey).value as? Int ?? 0
            let quintityValueStr1 =  obj.childSnapshot(forPath: quintityKey1).value as? Int ?? 0

            cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
            cell.lblText1.text = String(format: "%d",quintityValueStr)
            cell.lblText2.text = String(format: "%d",quintityValueStr1)

            let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
            let image:UIImage = UIImage(named: "back")!
            cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
            cell.selectionStyle = .none
            cell.buttonSetting.tag = (self.purchasedOrderArray.count - 1) - indexPath.row
            cell.buttonSetting.addTarget(self,action:#selector(buttonSetting3),for:.touchUpInside)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProyectadoTableViewCell", for: indexPath) as! ProyectadoTableViewCell
            return cell
            
        }
        
        
    }
    
    
    @objc func buttonSetting(sender:UIButton) -> Void{
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlaneamientoDeLaDemsndaDetails1VC") as! PlaneamientoDeLaDemsndaDetails1VC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.productID = obj.key
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @objc func buttonSetting3(sender:UIButton) -> Void{
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlaneamientoDeLaDemsndaDetails3VC") as! PlaneamientoDeLaDemsndaDetails3VC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.productObj = obj
        self.present(nextViewController, animated: true, completion: nil)
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
        if scrollView == scrollView1 {
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
