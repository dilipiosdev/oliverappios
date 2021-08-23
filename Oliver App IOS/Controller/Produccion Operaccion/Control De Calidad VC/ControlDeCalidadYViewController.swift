//
//  ControlDeCalidadYViewController.swift
//  Oliver App IOS
//
//  Created by apple on 16/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class ControlDeCalidadYViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var calidadView: UIView!
    @IBOutlet weak var defectosView: UIView!
    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
        companyId = companyDetailDict.key
        tbl1.register(UINib(nibName: "CalidadTableViewCell1", bundle: nil), forCellReuseIdentifier: "CalidadTableViewCell1")
        tbl2.register(UINib(nibName: "DefectosTableViewCell", bundle: nil), forCellReuseIdentifier: "DefectosTableViewCell")
        getProductList()
        lbl2.isHidden = true
        lbl1.isHidden = false
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
                for item in array {
                    let dict = item as? DataSnapshot
                    let state = dict?.childSnapshot(forPath: "state").value as? String ?? ""
                    if state == "ready"
                    {
                        self.purchasedOrderArray.append(item)
                    }
                }
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
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl1
        {
            return self.purchasedOrderArray.count
        } else {
            return self.purchasedOrderArray.count
        }
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
      {
        if tableView == tbl1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalidadTableViewCell1", for: indexPath) as! CalidadTableViewCell1
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
            cell.lbl1.text = obj.childSnapshot(forPath: "date").value as? String ?? ""
            cell.lbl2.text = obj.childSnapshot(forPath: "product_name").value as? String ?? ""
            cell.lbl3.text = obj.childSnapshot(forPath: "product_quantity_production").value as? String ?? ""
            let qualityControl = obj.childSnapshot(forPath: "Quality Control").hasChildren()
            var strControl = String()
            if qualityControl {
                strControl = "Listo"
            } else {
                strControl = "Sin Control"
            }
            cell.lbl4.text = strControl
            cell.buttonSetting.addTarget(self,action:#selector(buttonSetting),for:.touchUpInside)
            cell.buttonSetting.tag = (self.purchasedOrderArray.count - 1) - indexPath.row
           return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefectosTableViewCell", for: indexPath) as! DefectosTableViewCell
            let obj = self.purchasedOrderArray[(self.purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
           
            let product_quantity_production = obj.childSnapshot(forPath: "product_quantity_production").value as? String ?? "0"
            
            let qualityControl = obj.childSnapshot(forPath: "Quality Control").hasChildren()
            if qualityControl {
                let value1 = obj.childSnapshot(forPath: "Quality Control").childSnapshot(forPath: "quality_control_1").value as? Int ?? 0
                let value2 = obj.childSnapshot(forPath: "Quality Control").childSnapshot(forPath: "quality_control_2").value as? Int ?? 0
                let value3 = obj.childSnapshot(forPath: "Quality Control").childSnapshot(forPath: "quality_control_3").value as? Int ?? 0
                let value4 = obj.childSnapshot(forPath: "Quality Control").childSnapshot(forPath: "quality_control_4").value as? Int ?? 0
                let value5 = obj.childSnapshot(forPath: "Quality Control").childSnapshot(forPath: "quality_control_5").value as? Int ?? 0
                let value6 = obj.childSnapshot(forPath: "Quality Control").childSnapshot(forPath: "quality_control_6").value as? Int ?? 0
                
           
                cell.lbl1.text = String(format: "%.0f", (Double(value1) / (Double(product_quantity_production) ?? 0))  * 100) + "%"
                cell.lbl2.text = String(format: "%.0f", (Double(value2) / (Double(product_quantity_production) ?? 0))  * 100) + "%"
                cell.lbl3.text = String(format: "%.0f", (Double(value3) / (Double(product_quantity_production) ?? 0))  * 100) + "%"
                cell.lbl4.text = String(format: "%.0f", (Double(value4) / (Double(product_quantity_production) ?? 0))  * 100) + "%"
                cell.lbl5.text = String(format: "%.0f", (Double(value5) / (Double(product_quantity_production) ?? 0))  * 100) + "%"
                cell.lbl6.text = String(format: "%.0f", (Double(value6) / (Double(product_quantity_production) ?? 0))  * 100) + "%"
            }
            
           return cell
        }
      }
    
    @objc func buttonSetting(sender:UIButton) -> Void{
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddControlCalidadViewController") as! AddControlCalidadViewController
        nextViewController.companyDetailDict = companyDetailDict
        let obj = self.purchasedOrderArray[sender.tag] as! DataSnapshot
        nextViewController.productDetailDict = obj
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
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
        scrollToPage(page: 0, animated: true)

    }
  
    @IBAction func btn2(_ sender: Any) {
        lbl1.isHidden = true
        lbl2.isHidden = false
        scrollToPage(page: 1, animated: true)

    }
   
  
}
