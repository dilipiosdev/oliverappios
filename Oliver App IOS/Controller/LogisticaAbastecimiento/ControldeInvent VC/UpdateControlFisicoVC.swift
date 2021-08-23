//
//  UpdateControlFisicoVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 05/03/21.
//

import UIKit
import Firebase
import JGProgressHUD
class UpdateControlFisicoVC: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lableProductTitle: UILabel!
    @IBOutlet weak var txtField: UITextField!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var wareHosesKey = String()
    var companyUpdateKey = String()
    var imageURL = String()
    var productName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        let url = NSURL(string: String(format: "%@",imageURL))
        let image:UIImage = UIImage(named: "back")!
        productImage.af.setImage(withURL: url! as URL, placeholderImage: image)
        lableProductTitle.text = String(format: "Conteo fisico para: %@", productName)
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func buttonSubmit(_ sender: Any) {
       let textValue = Double(txtField.text ?? "0.00") ?? 0.00
        if (textValue > 0)
        {
            let userRef =  Database.database().reference().child("My Companies/\(self.companyId)").child("Warehouses").child(self.wareHosesKey).child("Products").child(self.companyUpdateKey)
            userRef.observeSingleEvent(of: .value) { (snapshot) in
                if let dic = snapshot.value as? Dictionary<String,Any>
                {
                    let value = Int(dic["product_stock"] as? String ?? "0") ?? 0
                    
                   let wareValue = (value - (Int(self.txtField.text ?? "0") ?? 0))
                    Database.database().reference().child("My Companies/\(self.companyId)").child("Warehouses").child(self.wareHosesKey).child("Products").child(self.companyUpdateKey).updateChildValues(["product_stock": String(format: "%d", wareValue)])
                    
                    let productValue = (value + (Int(self.txtField.text ?? "0") ?? 0))
                    Database.database().reference().child("My Companies/\(self.companyId)").child("My Products").child(self.companyUpdateKey).updateChildValues(["product_stock": String(format: "%d", productValue)])
                }
                else
                {
                    
                }
            }
            
            
           Database.database().reference().child("My Companies/\(companyId)").child("Kardex").child(wareHosesKey).updateChildValues(["product_stock_manual_count": String(format: "%@", txtField.text ?? "0")])
            
            
             self.dismiss(animated: true, completion: nil)
        }
        else {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Este monto sobrepasa tu stock actual.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
         
    }
}
