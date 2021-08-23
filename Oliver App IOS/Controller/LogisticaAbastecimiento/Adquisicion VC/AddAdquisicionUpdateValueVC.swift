//
//  AddAdquisicionUpdateValueVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 16/02/21.
//

import UIKit
import Firebase
import JGProgressHUD



class AddAdquisicionUpdateValueVC: UIViewController {
    var companyId = String()
    var companyDetailDict = DataSnapshot()
    var companyDetailDict111 = DataSnapshot()
    var purchaseKey = String()
    var strValue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
    }
    
    
    @IBAction func btn1(_ sender: Any) {
        strValue = "canceled"
        updateValue(str: strValue)
    }
    @IBAction func btn2(_ sender: Any) {
        strValue = "supplier_rejected"
        updateValue(str: strValue)

    }
    @IBAction func btn3(_ sender: Any) {
        strValue = "returned"
        updateValue(str: strValue)


    }
    @IBAction func btn4(_ sender: Any) {
       

    }
    
    func updateValue(str: String) -> Void {
      
        Database.database().reference().child("My Companies/\(companyId)").child("Purchased Orders").child(purchaseKey).updateChildValues([
            "purchase_order_state" : strValue
        ])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
