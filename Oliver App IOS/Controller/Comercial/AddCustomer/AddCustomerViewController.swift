//
//  AddCustomerViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 22/01/21.
//

import UIKit
import Firebase

class AddCustomerViewController: UIViewController {

    @IBOutlet weak var buttonPersona: UIButton!
    @IBOutlet weak var buttonEmpresa: UIButton!
    var selectPersonaStr = String()
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtRegisterNombre: UITextField!
    @IBOutlet weak var txtTelePhone: UITextField!
    let calendar = Calendar.current
    let date = Date()
    var day = Int()
    var month = Int()
    var year = Int()
    var companyDetailDict = DataSnapshot()
    var companyIDValue = String()
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    var countryCode = String()
    var customer_define = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyIDValue = companyDetailDict.key

        /***************Get Current Date ********************/
         day = calendar.component(.day, from: date)
         month = calendar.component(.month, from: date)
         year = calendar.component(.year, from: date)
        /***********************************************************/
        // Do any additional setup after loading the view.
        selectPersonaStr = "Persona"
        lblCountryName.text = "India"
        imgCountry.image = UIImage(named: "IND.png")

    }

    
    @IBAction func buttonPerson(_ sender: Any) {
        selectPersonaStr = "Persona"
        buttonEmpresa.backgroundColor = .white
        buttonPersona.backgroundColor = .lightGray
    }
    @IBAction func buttonEmpesa(_ sender: Any) {
        selectPersonaStr = "Empresa"
        buttonEmpresa.backgroundColor = .lightGray
        buttonPersona.backgroundColor = .white
    }
    @IBAction func buttonRegistro(_ sender: Any) {
        let date = Date()
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let timeStrSave = String(format: "%d-%d-%d%d:%d:%d", components.day!,components.month!,components.year!,components.hour!,components.minute!,components.second!)
        let dateStr = String(format: "%d-%d-%d%", components.day!,components.month!,components.year!)
        let timeStr = String(format: "%d:%d:%d",components.hour!,components.minute!,components.second!)
        
        if(customer_define.count == 0)
        {
            customer_define = "contact"
        }
        Database.database().reference().child("My Companies").child(companyIDValue).child("Customers").child(timeStrSave).updateChildValues([
            "customer_email": txtCorreo.text ?? "",
            "customer_name": txtRegisterNombre.text ?? "",
            "customer_phone": txtTelePhone.text ?? "",
            "customer_type" : selectPersonaStr,
            "register_date" : dateStr,
            "register_time" : timeStr,
            "customer_define" : customer_define,
        ])
        txtCorreo.text = ""
        txtRegisterNombre.text = ""
        txtTelePhone.text = ""
        selectPersonaStr = "Persona"
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonCancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
    
}

extension AddCustomerViewController: ADCountryPickerDelegate {
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        countryCode = dialCode
        let x =  picker.getFlag(countryCode: code)
        imgCountry.image = x
        if(code == "US")
        {
            imgCountry.image = UIImage(named: "US1.png")
            lblCountryName.text =  "United State"
        }
        lblCountryName.text =  picker.getCountryName(countryCode: code)
        let xxx =  picker.getDialCode(countryCode: code)
    }
}

