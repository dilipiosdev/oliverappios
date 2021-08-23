//
//  LoginWithPinViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 06/11/20.
//

import UIKit
import WaveAnimationView
import Firebase
import JGProgressHUD

class LoginWithPinViewController: UIViewController {
    
    var wave: WaveAnimationView!
    @IBOutlet var subViewAnimation: UIView!
    @IBOutlet var buttonConfirm: UIButton!
    @IBOutlet var subViewOtp: UIView!
    var userID = String()
    @IBOutlet var txtOtp: UITextField!
    var userName = String()
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet var subviewtop: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manageView()
        self.navigationController?.navigationBar.isHidden = true
        lblUserName.text = "Hola, " + userName

    }
    
    
    func manageView() -> Void {
        subViewOtp.layer.cornerRadius = 5
        buttonConfirm.layer.cornerRadius = 5
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
    

    @IBAction func buttonConfirm(_ sender: Any)
    {
        
        if(txtOtp.text?.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Please enter PIN.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
         let hud = JGProgressHUD(style: .light)
         hud.textLabel.text = "Loading"
         hud.show(in: self.view)
        
         let userIDStr = String(format: "Users/%@", userID)
         let userRef = Database.database().reference().child(userIDStr)
             
         userRef.observeSingleEvent(of: .value) { (snapshot) in
         if let dict = snapshot.value as? [String: Any]
         {
            hud.dismiss()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
         }
      }
   }
}
