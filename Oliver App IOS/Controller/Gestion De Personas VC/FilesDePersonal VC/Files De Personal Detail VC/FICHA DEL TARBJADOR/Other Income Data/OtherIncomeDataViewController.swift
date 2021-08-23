//
//  OtherIncomeDataViewController.swift
//  Oliver App IOS
//
//  Created by apple on 16/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class OtherIncomeDataViewController: UIViewController {
    @IBOutlet var otherIncomeAmtTF: UITextField!
    @IBOutlet var otherIncomeCompanyTF: UITextField!
    @IBOutlet var otherIncomeRUCTF: UITextField!
    var company_Id = String()
    var worker_Id = String()
    
    @IBOutlet var yesBtn: UIButton!
    @IBOutlet var noBtn: UIButton!
    @IBOutlet var popUpYesBtn: UIButton!
    @IBOutlet var  popUpNoBtn: UIButton!
    
    @IBOutlet var  popUpView: UIView!
    @IBOutlet var  mainView: UIView!



    override func viewDidLoad() {
        super.viewDidLoad()
        self.yesBtn.backgroundColor = UIColor.darkGray
         self.noBtn.backgroundColor = UIColor.white
        
        self.popUpYesBtn.backgroundColor = UIColor.white
       self.popUpNoBtn.backgroundColor = UIColor.white
        
        self.mainView.isHidden = true
        self.popUpView.isHidden = false
    }
    
     @IBAction func noBtnTapped(_ sender: Any) {
        self.mainView.isHidden = true
        self.popUpView.isHidden = false
        
    }
    
    @IBAction func popUpCloseBtnTapped(_ sender: Any) {
        self.popUpView.isHidden = true
       }
    
    @IBAction func popUpYesBtnTapped(_ sender: Any) {
        self.mainView.isHidden = false
        self.popUpView.isHidden = true
      }
    
    @IBAction func popUpNoBtnTapped(_ sender: Any) {
          
      }
    
    @IBAction func registerInfoBtnTapped(_ sender: Any) {
          
          if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                         self.worker_Id = dict["Worker_Id"]!
                         self.company_Id = dict["Compnay_Id"]!
                     }
    
                    let dict:[AnyHashable : Any] = [
                      "other_income_amount": self.otherIncomeAmtTF.text!,
                        "other_income_company": self.otherIncomeCompanyTF.text!,
                        "other_income_ruc" : self.otherIncomeRUCTF.text!
                    ]
                    print(dict)
                  Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
                        .child(self.worker_Id).child("Personal File").child("Other Incomes").updateChildValues(dict)
                    self.dismiss(animated: true, completion: nil)
         }
 
}
