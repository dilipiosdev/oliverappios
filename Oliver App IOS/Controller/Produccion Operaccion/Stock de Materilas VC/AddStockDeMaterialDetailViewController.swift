//
//  AddStockDeMaterialDetailViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 18/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddStockDeMaterialDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    var imageURL = String()
    var productName = String()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var obj = DataSnapshot()
    var wareHosesKey = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        lblProductName.text = String(format: obj.childSnapshot(forPath: "product_name").value as? String ?? "0.00")
        let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        productImage.af.setImage(withURL: url! as URL, placeholderImage: image)
        
        
    }
    @IBOutlet weak var txtView: UITextField!
    @IBAction func buttonRegister(_ sender: Any) {
        var valueStr = String()
        if Int(txtView.text ?? "0") ?? 0 >= 10  {
            valueStr = "A"
        } else if Int(txtView.text ?? "0") ?? 0 >= 5 && Int(txtView.text ?? "0") ?? 0 <= 9 {
            valueStr = "B"
        } else if (Int(txtView.text ?? "0") ?? 0 < 4){
            valueStr = "C"
        }
        
        
        
        Database.database().reference().child("My Companies").child(companyId).child("Warehouses").child(wareHosesKey).child("Products").child(obj.key).updateChildValues([
            "product_category" : valueStr,
        ])
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
