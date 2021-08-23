//
//  AddFechaViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 07/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddFechaViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textViewDetails: UITextView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var titleStr = String()
    var tagValue = Int()
    var productKey = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        lblTitle.text = titleStr

    }

    @IBAction func buttonSubmit(_ sender: Any) {
        if tagValue == 0 {
            Database.database().reference().child("My Companies").child(self.companyId).child("My Products").child(productKey).updateChildValues([
                "product_description" : textViewDetails.text ?? ""
            ])
        } else if tagValue == 1 {
            Database.database().reference().child("My Companies").child(self.companyId).child("My Products").child(productKey).updateChildValues([
                "product_specifications" : textViewDetails.text ?? ""
            ])
        } else if tagValue == 2 {
            Database.database().reference().child("My Companies").child(self.companyId).child("My Products").child(productKey).updateChildValues([
                "product_measurements" : textViewDetails.text ?? ""
            ])
            
        } else if tagValue == 3 {
            Database.database().reference().child("My Companies").child(self.companyId).child("My Products").child(productKey).updateChildValues([
                "product_security_usage" : textViewDetails.text ?? ""
            ])
        }
        self.dismiss(animated: true, completion: nil)
        
   
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
