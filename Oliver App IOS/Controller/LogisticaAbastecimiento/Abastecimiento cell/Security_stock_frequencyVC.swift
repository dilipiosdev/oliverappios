//
//  Security_stock_frequencyVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 19/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class Security_stock_frequencyVC: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var productID = String()
    override func viewDidLoad() {
        companyId = companyDetailDict.key
        super.viewDidLoad()

    }
    @IBAction func btn1(_ sender: UIButton) {
        var valueStr = String()
        if  sender.tag == 1 {
            valueStr = "Mensual"
        }
        if  sender.tag == 2 {
            valueStr = "Quincenal"
        }
        if  sender.tag == 3 {
            valueStr = "Semanal"
        }
        if  sender.tag == 4 {
            valueStr = "Diario"
        }
  
        Database.database().reference().child("My Companies").child(companyId).child("My Products").child(productID).updateChildValues([
            "security_stock_frequency" : valueStr,
          
        ])
        self.dismiss(animated: true, completion: nil)
    }
  
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
