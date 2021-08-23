//
//  OrdenesViewController.swift
//  Oliver App IOS
//
//  Created by apple on 14/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class OrdenesViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate {
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var cadenaView: UIView!
    @IBOutlet weak var productosView: UIView!
    @IBOutlet weak var productosDetailsView: UIView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    var purchasedMyOrderArray = Array<Any>()
    @IBOutlet weak var bottomlbl1: UILabel!
    @IBOutlet weak var bottomlbl2: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    

   override func viewDidLoad() {
      super.viewDidLoad()
      tbl1.register(UINib(nibName: "OrdenesCadenaTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdenesCadenaTableViewCell")
      tbl2.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
       companyId = companyDetailDict.key
       bottomlbl1.isHidden = false
       bottomlbl2.isHidden = true

       getProductList()
       getMyProductList()
    }
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Production Chain")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedOrderArray = array
                self.tbl1.reloadData()

            }
            else
            {
                hud.dismiss()
            }
        }
    }
     
    func getMyProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Products")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedMyOrderArray = array
                self.tbl2.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
   
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl1 {
            return self.purchasedOrderArray.count
        } else {
            return self.purchasedMyOrderArray.count
        }
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  tableView == tbl1 {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "OrdenesCadenaTableViewCell", for: indexPath) as! OrdenesCadenaTableViewCell
            let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
            cell.lblText1.text = obj.childSnapshot(forPath: "date").value as? String ?? ""
            cell.lblText2.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
            cell.lblText3.text = obj.childSnapshot(forPath: "product_quantity_production").value as? String ?? ""
            cell.lblText4.text = obj.childSnapshot(forPath: "state").value as? String ?? ""
            var state = String()
            state = obj.childSnapshot(forPath: "state").value as? String ?? ""
            if (state == "production"){
                cell.lblText4.text = "En Producción" }
            if (state == "stop"){
                cell.lblText4.text = "Detenido" }
            if (state == "ready"){
                cell.lblText4.text = "Listo"
                cell.subviewButton.isHidden = true
                
            }
            cell.buttonSetting.addTarget(self,action:#selector(buttonSetting1),for:.touchUpInside)
             return cell
        } else {
            let cell = tbl2.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedMyOrderArray[indexPath.row] as! DataSnapshot
            cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
            cell.lblText1.text = obj.childSnapshot(forPath: "product_stock").value as? String ?? ""
            let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
            let image:UIImage = UIImage(named: "back")!
            cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
            cell.selectionStyle = .none
            cell.lblText2.isHidden = true
            cell.lblText.textAlignment = .center
            cell.lblText1.textAlignment = .center
            cell.buttonSetting.addTarget(self,action:#selector(buttonSetting2),for:.touchUpInside)

             return cell
        }
     }
    @objc func buttonSetting1(sender:UIButton) -> Void {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddOrdenesViewController") as! AddOrdenesViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.productID = obj.key
        self.present(nextViewController, animated: true, completion: nil)
    }
    @objc func buttonSetting2(sender:UIButton) -> Void {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddOrdenesProductDetailsVC") as! AddOrdenesProductDetailsVC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.productObj = obj
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth:CGFloat = scrollView.frame.width
            let current:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        if current == 0 {
            bottomlbl1.isHidden = false
            bottomlbl2.isHidden = true

        } else {
            bottomlbl1.isHidden = true
            bottomlbl2.isHidden = false
        }
    }
    
    
    @IBAction func btn1(_ sender: Any) {
        bottomlbl1.isHidden = false
        bottomlbl1.isHidden = true
        scrollToPage(page: 0, animated: true)

    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    @IBAction func btn2(_ sender: Any) {
        bottomlbl2.isHidden = false
        bottomlbl1.isHidden = true
        scrollToPage(page: 1, animated: true)

    }
}
