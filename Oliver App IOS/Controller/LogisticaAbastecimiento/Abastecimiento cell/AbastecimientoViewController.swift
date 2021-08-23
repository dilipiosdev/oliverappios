//
//  AbastecimientoViewController.swift
//  Oliver App IOS
//
//  Created by apple on 07/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AbastecimientoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl1: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        tbl1.register(UINib(nibName: "DemandaTableViewCell", bundle: nil), forCellReuseIdentifier: "DemandaTableViewCell")
        tbl2.register(UINib(nibName: "StockSeguridadTableViewCell", bundle: nil), forCellReuseIdentifier: "StockSeguridadTableViewCell")
        getProductList()
        lbl1.isHidden = false
        lbl2.isHidden = true
    
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
                self.tbl2.reloadData()
                self.tbl1.reloadData()

                
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
        return purchasedOrderArray.count
        } else {
            return purchasedOrderArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tbl1 {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "DemandaTableViewCell", for: indexPath) as! DemandaTableViewCell
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
            
            
         
            cell.lbl1.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
            cell.lbl2.text = obj.childSnapshot(forPath: "product_stock").value as? String ?? ""

            
            
            let components = self.calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.date)
            var stockValue = Int()
            let stockKey = String(format: "%d%dquantity",components.year! - 1, components.month!)
                stockValue = stockValue + (obj.childSnapshot(forPath: stockKey).value as? Int ?? 0)
            cell.lbl4.text =  String(format: "%d", stockValue)

            
            
            var totalStockValue = Int()
             var compars = Int()
             for i in 1 ... 12
             {
                let stockKey = String(format: "%d%dquantity",components.year! - 1, i)
                 totalStockValue = stockValue + (obj.childSnapshot(forPath: stockKey).value as? Int ?? 0)
            }
            if (obj.childSnapshot(forPath: "security_stock_frequency").value as? String ?? "") == ""  {
                compars = totalStockValue/12
            } else if (obj.childSnapshot(forPath: "security_stock_frequency").value as? String ?? "") == "Mensual"  {
                compars = totalStockValue/12
            } else if (obj.childSnapshot(forPath: "security_stock_frequency").value as? String ?? "") == "Quincenal"  {
                compars = totalStockValue/24
            } else if (obj.childSnapshot(forPath: "security_stock_frequency").value as? String ?? "") == "Semanal"  {
                compars = totalStockValue/48
            } else if (obj.childSnapshot(forPath: "security_stock_frequency").value as? String ?? "") == "Diario"  {
                compars = totalStockValue/360
            }
            
            
            let value1 = Double(cell.lbl2.text ?? "0.00") ?? 0.00
            let value2 = Double(cell.lbl4.text ?? "0.00") ?? 0.00
            let value3 = compars


            cell.lbl3.text = String(format: "%d", Int(value2) + Int(value3) - Int(value1))
            let lbl2Value = cell.lbl3.text ?? "0"
            cell.lbl5.text = String(format: "%d", (Int(value1) + Int(lbl2Value)! - Int(value2)))

            
            
            
        
        let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
            let image:UIImage = UIImage(named: "back")!
            cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
            cell.selectionStyle = .none
            return cell
        } else {
        let cell = tbl2.dequeueReusableCell(withIdentifier: "StockSeguridadTableViewCell", for: indexPath) as! StockSeguridadTableViewCell
        let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
        cell.lblText.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
        cell.lblText1.text = obj.childSnapshot(forPath: "security_stock_frequency").value as? String ?? ""
        let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
        cell.selectionStyle = .none
        cell.buttonEdit.addTarget(self,action:#selector(buttonEdit),for:.touchUpInside)
        cell.buttonEdit.tag = indexPath.row
        return cell
        }
        
    }
    @objc func buttonEdit(sender:UIButton) -> Void{
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Security_stock_frequencyVC") as! Security_stock_frequencyVC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.productID = obj.key
        
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func btn1(_ sender: Any) {
        lbl1.isHidden = false
        lbl2.isHidden = true
        scrollToPage(page: 0, animated: true)

    }
    
    @IBAction func btn2(_ sender: Any) {
        lbl1.isHidden = true
        lbl2.isHidden = false
        scrollToPage(page: 1, animated: true)

    }
 
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth:CGFloat = scrollView.frame.width
            let current:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        if current == 0 {
            lbl1.isHidden = false
            lbl2.isHidden = true

        } else  if current == 1 {
            lbl1.isHidden = true
            lbl2.isHidden = false
        } else {
            lbl1.isHidden = true
            lbl2.isHidden = true
        }
    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
}
