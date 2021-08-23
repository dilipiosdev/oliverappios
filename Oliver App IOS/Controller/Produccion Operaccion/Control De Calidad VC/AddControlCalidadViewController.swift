//
//  AddControlCalidadViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 14/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddControlCalidadViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var productDetailDict = DataSnapshot()
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var labelProductStock: UILabel!
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var txt6: UITextField!

    var companyId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        
        let url = NSURL(string: String(format: "%@",productDetailDict.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        imageProduct.af.setImage(withURL: url! as URL, placeholderImage: image)
        
        labelProductStock.text = String(format: "Cantidad Producida:%@",productDetailDict.childSnapshot(forPath: "product_quantity_production").value as? String ?? "")
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        var match = false
        if Int(txt1.text ?? "0") ?? 0 < Int(productDetailDict.childSnapshot(forPath: "product_quantity_production").value as? String ?? "0") ?? 0 {
            match = true
        } else if Int(txt2.text ?? "0") ?? 0 < Int(productDetailDict.childSnapshot(forPath: "product_quantity_production").value as? String ?? "0") ?? 0 {
            match = true
        } else if Int(txt3.text ?? "0") ?? 0 < Int(productDetailDict.childSnapshot(forPath: "product_quantity_production").value as? String ?? "0") ?? 0 {
            match = true
        } else if Int(txt4.text ?? "0") ?? 0 < Int(productDetailDict.childSnapshot(forPath: "product_quantity_production").value as? String ?? "0") ?? 0 {
            match = true
        } else if Int(txt5.text ?? "0") ?? 0 < Int(productDetailDict.childSnapshot(forPath: "product_quantity_production").value as? String ?? "0") ?? 0 {
            match = true
        } else if Int(txt6.text ?? "0") ?? 0 < Int(productDetailDict.childSnapshot(forPath: "product_quantity_production").value as? String ?? "0") ?? 0 {
            match = true
        }
        if match == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "La cantidad NO COFORME? debe ser menor o igual al totoal de la cantidad.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        let timestamp = NSDate().timeIntervalSince1970
        let timeStampString = String(format: "%.0f",timestamp)
        
        let dict:[AnyHashable : Any] =
            [
                "quality_control_1" : txt1.text ?? "",
                "quality_control_2" : txt2.text ?? "",
                "quality_control_3" : txt3.text ?? "",
                "quality_control_4" : txt4.text ?? "",
                "quality_control_5" : txt5.text ?? "",
                "quality_control_6" : txt6.text ?? "",
                "timestamp" : timeStampString,
            ]
        
        Database.database().reference().child("My Companies").child(companyId).child("Production Chain").child(timeStampString).child("Quality Control").updateChildValues(dict)
        self.dismiss(animated: true, completion: nil)
    }
}
    

