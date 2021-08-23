//
//  AddOrdenesViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 09/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddOrdenesViewController: UIViewController {
 
    
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    var purchasedMyOrderArray = Array<Any>()
    var productID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
    }
    
    @IBAction func btn1(_ sender: Any) {
        
        Database.database().reference().child("My Companies/\(companyId)").child("Production Chain").child(productID).updateChildValues([
            "state" : "production",
        ])
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn2(_ sender: Any) {
        Database.database().reference().child("My Companies/\(companyId)").child("Production Chain").child(productID).updateChildValues([
            "state" : "stop",
        ])
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn3(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddOrdenesListViewController") as! AddOrdenesListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.productID = productID
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
