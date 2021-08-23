//
//  AddMantenimientoDeHerrVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 13/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddMantenimientoDeHerrVC: UIViewController,addCalendarDelegate {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    @IBOutlet weak var lblDia: UILabel!
    @IBOutlet weak var lblMes: UILabel!
    @IBOutlet weak var lblAno: UILabel!
    
    @IBOutlet weak var txtCon: UITextField!
    @IBOutlet weak var txtNom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func callAddCalendar(match: String, value: String) {
        if(match == "Date")
        {
            lblDia.text = value
            return
        }
        if(match == "Month")
        {
            lblMes.text = value
            return
        }
        if(match == "Year")
        {
           lblAno.text = value
           return
        }
    }
    
    
    @IBAction func buttonDay(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Date"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonMonth(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Month"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonAno(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Year"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        if txtCon.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar el Concepto.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else if txtNom.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar el Activo.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else if lblDia.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar el Dia.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else if lblMes.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar el Mes.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else if lblAno.text?.isEmpty == true {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar el Ano", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        } else {
        let timestamp = NSDate().timeIntervalSince1970
        let timeStampString = String(format: "%.0f",timestamp)
             let dict:[AnyHashable : Any] =
                [
                    "asset" : txtNom.text ?? "",
                    "concept" : txtCon.text ?? "",
                    "day" : lblDia.text ?? "",
                    "month" : lblMes.text ?? "",
                    "year" : lblAno.text ?? "",
                    "timestamp" : timeStampString,
                ]
                
        Database.database().reference().child("My Companies").child(companyId).child("Machinery Maintenance").child(timeStampString).updateChildValues(dict)
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
