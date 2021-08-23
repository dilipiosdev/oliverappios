//
//  UpdateDispatchViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 21/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class UpdateDispatchViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var dispachKey = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
    }

    @IBAction func buttUpdateon(_ sender: Any) {
        Database.database().reference().child("My Companies/\(companyId)").child("Dispatches").child(dispachKey).updateChildValues([
            "dispatch_state" : "ready",
        ])
        let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Registrado con Entregado.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertView.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)

    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
