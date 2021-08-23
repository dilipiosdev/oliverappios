//
//  AddSellerViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 07/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class AddSellerViewController: UIViewController {

    /****************Seller Addd*****/
    @IBOutlet weak var imgCountry1: UIImageView!
    @IBOutlet weak var lblCountryName1: UILabel!
    @IBOutlet weak var txtSellerName: UITextField!
    @IBOutlet weak var txtSellerNumber: UITextField!
    @IBOutlet weak var txtSellerDocumentNo: UITextField!
    @IBOutlet weak var txtSellerEmail: UITextField!
    
    let calendar = Calendar.current
    let date = Date()
    var day = Int()
    var month = Int()
    var year = Int()
    var companyDetailDict = DataSnapshot()
    var companyID = String()
    var countryCode = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        companyID = companyDetailDict.key
        lblCountryName1.text = "India"
        imgCountry1.image = UIImage(named: "IND.png")
        
    }
    


    
    @IBAction func buttonRegistorSeller(_ sender: Any) {
        if(txtSellerDocumentNo.text?.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Please Enter Document Number!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        else
        {
            let date = Date()
            let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let timeStrSave = String(format: "%d-%d-%d%%d:%d:%d%", components.day!,components.month!,components.year!,components.hour!,components.minute!,components.second!)
            let dateStr = String(format: "%d-%d-%d%", components.day!,components.month!,components.year!)
            let timeStr = String(format: "%d:%d:%d%",components.hour!,components.minute!,components.second!)
            
            Database.database().reference().child("My Companies").child(companyID).child("Sellers").child(txtSellerDocumentNo.text ?? "0").updateChildValues([
                "seller_email": txtSellerEmail.text ?? "",
                "seller_name": txtSellerName.text ?? "",
                "seller_phone": txtSellerNumber.text ?? "",
                "seller_document_number" : txtSellerDocumentNo.text ?? "",
                "register_date" : dateStr,
                "register_time" : timeStr
            ])
            txtSellerName.text = ""
            txtSellerEmail.text = ""
            txtSellerNumber.text = ""
            txtSellerDocumentNo.text = ""
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func buttonSelectCountry(_ sender: Any) {
        let picker = ADCountryPicker(style: .grouped)
        picker.delegate = self
        picker.showCallingCodes = true
        picker.didSelectCountryClosure = { name, code in
            _ = picker.navigationController?.popToRootViewController(animated: true)
            print(code)
        }
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    @IBAction func buttonCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension AddSellerViewController: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        countryCode = dialCode
        
        let x =  picker.getFlag(countryCode: code)
        imgCountry1.image = x
        
        if(code == "US")
        {
            
            imgCountry1.image = UIImage(named: "US1.png")
            lblCountryName1.text =  "United State"
            
        }
        lblCountryName1.text =  picker.getCountryName(countryCode: code)
        let xxx =  picker.getDialCode(countryCode: code)
    }
}
