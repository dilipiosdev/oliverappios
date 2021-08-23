//
//  OtpViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 06/11/20.
//

import UIKit
import WaveAnimationView
import Firebase
import JGProgressHUD

class OtpViewController: UIViewController {

    @IBOutlet var buttonVerification: UIButton!
    @IBOutlet var subViewOtp: UIView!
    @IBOutlet var subViewAnimation: UIView!
    var wave: WaveAnimationView!
    var credential: PhoneAuthCredential?
    var verificationID12: String?
    var phoneNumber: String?

    @IBOutlet var subviewtop: UIView!
    @IBOutlet var txtOtp: UITextField!
    
    @IBOutlet var subviewTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manageView()
//        wave = WaveAnimationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 15), frontColor: #colorLiteral(red: 0.5882352941, green: 0.6, blue: 0.9215686275, alpha: 1), backColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
//        wave.progress = 0.5
//        wave.startAnimation()
//        self.subViewAnimation.addSubview(wave)
        
        
     
    }
    
    
    func manageView() -> Void {
        subViewOtp.layer.cornerRadius = 5
        buttonVerification.layer.cornerRadius = 5
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size.width = UIScreen.main.bounds.width
        gradientLayer.frame.size.height = UIScreen.main.bounds.height
        gradientLayer.colors = [UIColor(displayP3Red: 0.0/255.0, green: 151.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.subviewtop.layer.addSublayer(gradientLayer)
        self.subviewtop.layer.addSublayer(gradientLayer)
    }
  
    override func viewDidDisappear(_ animated: Bool) {
       // wave.stopAnimation()
    }
    
    @IBAction func buttonVerification(_ sender: Any)
    {
        if(txtOtp.text!.count <= 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Please enter otp.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            
        }
        else
        {
            SignWithOtp()
        }
       
    }
    
    
    
    func SignWithOtp() -> Void
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID12!,verificationCode: txtOtp.text!)
        Auth.auth().signIn(with: credential!)
         { (authResult, error) in
           if let error = error
           {
             let authError = error as NSError
             hud.dismiss()
             let alertView: UIAlertController = UIAlertController(title: "", message: "Debes ingresar el codigo de verificacion.", preferredStyle: .alert)
                 let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                 alertView.dismiss(animated: true, completion: nil)
             }
             alertView.addAction(alertAction)
             self.present(alertView, animated: true, completion: {
                self.navigationController?.popViewController(animated: true)
             })
           }
           else
           {
             print("Sucessfull")
             print(authResult?.user.uid ?? "")
             if(authResult?.user.uid.count != 0)
             {
                
                    let userID = String(format: "Users/%@", authResult!.user.uid)
                    let userRef = Database.database().reference().child(userID)
                    userRef.observeSingleEvent(of: .value) { (snapshot) in
                    if let dict = snapshot.value as? [String: Any]
                    {
                        hud.dismiss()
                        if((dict["pin"] as? String ?? "").count > 0)
                         {
                             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginWithPinViewController") as! LoginWithPinViewController
                            nextViewController.userName = dict["name"] as? String ?? ""
                            UserDefaults.standard.set(dict["pin"] as? String ?? "", forKey: "Pin")
                            UserDefaults.standard.set(authResult!.user.uid, forKey: "UserFireBaseID")
                            appDelegate.userID = authResult!.user.uid

                             self.navigationController?.pushViewController(nextViewController, animated: true)
                         }
                         else
                         {
                            print(authResult!.user.uid)
                            UserDefaults.standard.set(authResult!.user.uid, forKey: "UserFireBaseID")
                            appDelegate.userID = authResult!.user.uid
                             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                             nextViewController.userID = (authResult?.user.uid)!
                             self.navigationController?.pushViewController(nextViewController, animated: true)
                         }
                    }
                    else
                    {
                        print(authResult!.user.uid)
                        UserDefaults.standard.set(authResult!.user.uid, forKey: "UserFireBaseID")
                        appDelegate.userID = authResult!.user.uid
                        hud.dismiss()
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                        nextViewController.userID = (authResult?.user.uid)!
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }
                }
            }
        }
    }
}
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField == txtOtp)
        {
          guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
          }
          let substringToReplace = textFieldText[rangeOfTextToReplace]
          let count = textFieldText.count - substringToReplace.count + string.count
          return count <= 4
        }
        return true
    }
    
}
