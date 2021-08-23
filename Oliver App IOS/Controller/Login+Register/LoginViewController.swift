//
//  LoginViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 05/11/20.
//

import UIKit
import WaveAnimationView
import Firebase
import JGProgressHUD

class LoginViewController: UIViewController,UITextFieldDelegate {
    var wave: WaveAnimationView!

    @IBOutlet var subViewAnimation: UIView!
    @IBOutlet var buttonContinue: UIButton!
    @IBOutlet var subViewCountry: UIView!
    @IBOutlet var subViewNumber: UIView!

    @IBOutlet var subViewtop: UIView!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var lblCountryCode: UILabel!
    @IBOutlet var imgCountry: UIImageView!
    var countryCode = String()
    
    
    var verificationID12: String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        manageView()
//        wave = WaveAnimationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 15), frontColor: #colorLiteral(red: 0.5882352941, green: 0.6, blue: 0.9215686275, alpha: 1), backColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
//        wave.progress = 0.5
//        wave.startAnimation()
//        self.subViewAnimation.addSubview(wave)
        countryCode = "+91"

    }

  
    
    func manageView() -> Void {
        subViewNumber.layer.cornerRadius = 5
        subViewCountry.layer.cornerRadius = 5
        buttonContinue.layer.cornerRadius = 5
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size.width = UIScreen.main.bounds.width
        gradientLayer.frame.size.height = UIScreen.main.bounds.height
        gradientLayer.colors = [UIColor(displayP3Red: 0.0/255.0, green: 151.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.subViewtop.layer.addSublayer(gradientLayer)
        self.subViewtop.layer.addSublayer(gradientLayer)

    }
    override func viewDidDisappear(_ animated: Bool) {
       // wave.stopAnimation()
    }
    
    
    @IBAction func buttonContinue(_ sender: Any) {
        
        if(countryCode.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Please select Country.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            
        }
        else if(txtMobile.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar tu numero de telefone.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            
        }
        else
        {
            let hud = JGProgressHUD(style: .light)
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            let mobileNumber = String(format: "%@%@", countryCode,txtMobile.text!)
            PhoneAuthProvider.provider().verifyPhoneNumber(mobileNumber, uiDelegate: nil) {  (verificationID, error) in
            if let error = error
            {
                print("error...........")
                hud.dismiss()
                let alertView: UIAlertController = UIAlertController(title: self.title, message: "Please Try Again!", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertView.dismiss(animated: true, completion: nil)
                }
                alertView.addAction(alertAction)
                self.present(alertView, animated: true, completion: nil)

              return
            }
            else
           {
              appDelegate.phoneNumber = self.txtMobile.text ?? ""
              hud.dismiss()
              self.verificationID12 = verificationID
              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
              let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
              nextViewController.verificationID12 = self.verificationID12
              nextViewController.phoneNumber = mobileNumber
              self.navigationController?.pushViewController(nextViewController, animated: true)
            }
          }
        }
    }
    

    @IBAction func buttonContryCode(_ sender: Any) {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField == txtMobile)
        {
          guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
          }
          let substringToReplace = textFieldText[rangeOfTextToReplace]
          let count = textFieldText.count - substringToReplace.count + string.count
          return count <= 10
        }
        return true
    }
}
extension LoginViewController: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        lblCountryCode.text = code + dialCode
        countryCode = dialCode

        let x =  picker.getFlag(countryCode: code)
        imgCountry.image = x

        if(code == "US")
        {
            imgCountry.image = UIImage(named: "US1.png")
        }
        let xx =  picker.getCountryName(countryCode: code)
        let xxx =  picker.getDialCode(countryCode: code)
    }
}
