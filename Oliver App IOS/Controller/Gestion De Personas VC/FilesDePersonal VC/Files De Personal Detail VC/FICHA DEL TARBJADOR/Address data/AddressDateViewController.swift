//
//  AddressDateViewController.swift
//  Oliver App IOS
//
//  Created by apple on 15/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class AddressDateViewController: UIViewController {
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var addressRefTF: UITextField!
    @IBOutlet var fixedPhoneTF: UITextField!
    @IBOutlet var mobilePhoneTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var emergencyContactNameTF: UITextField!
    @IBOutlet var emergencyContactPhoneTF: UITextField!
    
    var company_Id = String()
   var worker_Id = String()



    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerInfoBtnTapped(_ sender: Any) {
          
          if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                         self.worker_Id = dict["Worker_Id"]!
                         self.company_Id = dict["Compnay_Id"]!
                     }
    
                    let dict:[AnyHashable : Any] = [
                      "address": self.addressTF.text!,
                        "address_reference": self.addressRefTF.text!,
                        "fixed_phone": self.fixedPhoneTF.text!,
                        "mobile_phone" : self.mobilePhoneTF.text!,
                        "email" : self.emailTF.text!,
                        "emergency_contact_name": self.emergencyContactNameTF.text!,
                        "emergency_contact_phone": self.emergencyContactPhoneTF.text!

                    ]
                    print(dict)
                  Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
                        .child(self.worker_Id).child("Personal File").child("Address Data").updateChildValues(dict)
                    self.dismiss(animated: true, completion: nil)
          
         }
 
}
