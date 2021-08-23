//
//  AddCapacidadoViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 12/03/21.
//

import UIKit
import JGProgressHUD
import Firebase

class AddCapacidadoViewController: UIViewController {
    @IBOutlet weak var txtNom: UITextField!
    @IBOutlet weak var txtCap: UITextField!
    @IBOutlet weak var txtHor: UITextField!
    @IBOutlet weak var txtPro: UITextField!
    
    
    
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    override func viewDidLoad() {
        companyId = companyDetailDict.key
        super.viewDidLoad()

    }
    @IBAction func buttonRegister(_ sender: Any) {
        if txtNom.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar el nomber de la linea de produccion.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else if txtCap.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar la capacidad teorica.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else if txtHor.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar las horas hombre.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else if txtPro.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar la produccion real.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else {
            let timestamp = NSDate().timeIntervalSince1970
            let timeStampString = String(format: "%.0f",timestamp)
            Database.database().reference().child("My Companies").child(companyId).child("Production Lines").child(timeStampString).updateChildValues([
                "production_line_name" : txtNom.text ?? "",
                "production_theoretical_capacity" : txtCap.text ?? "",
                "production_man_time" : txtHor.text ?? "",
                "production_real_production" : txtPro.text ?? "",
                "timestamp" : timeStampString,

            ])
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
