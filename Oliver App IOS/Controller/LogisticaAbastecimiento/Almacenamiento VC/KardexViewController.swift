//
//  KardexViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 02/03/21.
//

import UIKit
import Firebase
import JGProgressHUD
class KardexViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var productObj = DataSnapshot()
    var wareHouseName = String()
    var wareHosesKey = String()
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var tbl1: UITableView!
    var purchasedOrderArray = Array<Any>()
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl3: UITableView!
    @IBOutlet weak var labelWareHouseName: UILabel!
    
    @IBOutlet weak var labelStock: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        let url = NSURL(string: String(format: "%@",productObj.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        productImage.af.setImage(withURL: url! as URL, placeholderImage: image)
        labelProductName.text = productObj.childSnapshot(forPath: "product_name").value as? String ?? ""
        labelWareHouseName.text = "ALMACEN: " + wareHouseName
        
        tbl1.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        tbl2.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        tbl3.register(UINib(nibName: "RealTableViewCell", bundle: nil), forCellReuseIdentifier: "RealTableViewCell")
        
        labelStock.text = "STOCK TOTAL: " + (productObj.childSnapshot(forPath: "product_stock").value as? String ?? "")
        labelProductPrice.text =  "VALOR TOTAL: S/ " + String(format: "%.2f", ((Double(String(format: productObj.childSnapshot(forPath: "product_price").value as? String ?? "0.00")) ?? 0.00) * (Double(String(format: "%@", (productObj.childSnapshot(forPath: "product_stock").value as? String ?? "0.00"))) ?? 0.00)))
        getProductList()
    }
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Kardex")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                for item in array {
                    let obj = item as? DataSnapshot
                    if (obj?.childSnapshot(forPath: "product_id").value as? String ?? "" == self.productObj.key )
                    {
                        self.purchasedOrderArray.append(item)
                    }
                }
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
}
extension KardexViewController : UITabBarDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tbl1
        {
            return purchasedOrderArray.count
        } else if tableView == tbl2 {
            return purchasedOrderArray.count
        }  else {
            return purchasedOrderArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl1
        {
            let cell = tbl1.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
            cell.lblText.text = obj.childSnapshot(forPath: "operation_date").value as? String ?? ""
            
            let operation_type = obj.childSnapshot(forPath: "operation_type").value as? String ?? ""
            var conceptoStr = String()
            if (operation_type == "purchase"){
                conceptoStr = "Compra o Fabricación"
            }
            if (operation_type == "from_store_transfer"){
                conceptoStr = "Transferencia desde Tienda"
            }
            if (operation_type == "warehouse_transfer"){
                conceptoStr = "Transferencia entre almacenes"
            }
            if (operation_type == "to_store_transfer"){
                conceptoStr = "Transferencia a Tienda" }
            if (operation_type == "inventory_control"){
                conceptoStr = "Ajuste de Inventario" }
            if (operation_type == "production"){
                conceptoStr = "Para Producción" }
            cell.lblText1.text = ""
            cell.lblText2.text = conceptoStr
            cell.imgView.isHidden = true
            cell.subViewSetting.isHidden = true
            return cell
        } else if tableView == tbl2 {
            let cell = tbl2.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
            cell.lblText.text = obj.childSnapshot(forPath: "product_price").value as? String ?? ""
            
            let operation_type = obj.childSnapshot(forPath: "operation_type").value as? String ?? ""
            var conceptoStr = String()
            if (operation_type == "purchase"){
                conceptoStr = "Compra o Fabricación"
            }
            if (operation_type == "from_store_transfer"){
                conceptoStr = "Transferencia desde Tienda"
            }
            if (operation_type == "warehouse_transfer"){
                conceptoStr = "Transferencia entre almacenes"
            }
            if (operation_type == "to_store_transfer"){
                conceptoStr = "Transferencia a Tienda" }
            if (operation_type == "inventory_control"){
                conceptoStr = "Ajuste de Inventario" }
            if (operation_type == "production"){
                conceptoStr = "Para Producción" }
            cell.lblText1.text = ""
            cell.lblText2.text = conceptoStr
            cell.imgView.isHidden = true
            cell.subViewSetting.isHidden = true
            return cell
        } else {
            let cell = tbl2.dequeueReusableCell(withIdentifier: "RealTableViewCell", for: indexPath) as! RealTableViewCell
            let obj = self.purchasedOrderArray[(purchasedOrderArray.count - 1) - indexPath.row] as! DataSnapshot
            cell.lblText.text = "S/ " + String(format: obj.childSnapshot(forPath: "product_price").value as? String ?? "0.00")
             cell.lblText1.text =  String(format: obj.childSnapshot(forPath: "stock").value as? String ?? "0.00")
        
             cell.lblText2.text = "S/ " + String(format: "%.2f", ((Double(String(format: obj.childSnapshot(forPath: "product_price").value as? String ?? "0.00")) ?? 0.00) * (Double(String(format: "%@", (obj.childSnapshot(forPath: "stock").value as? String ?? "0.00"))) ?? 0.00)))
           cell.lblText.textAlignment = .left
           cell.lblText2.textAlignment = .right
           cell.imgView.isHidden = true
           cell.selectionStyle = .none
           cell.subViewSetting.isHidden = true
            return cell
        }
        
    }
    @objc func buttonSetting1(sender:UIButton) -> Void{
    }
    
    @objc func buttonSetting2(sender:UIButton) -> Void{
    }
    
}



