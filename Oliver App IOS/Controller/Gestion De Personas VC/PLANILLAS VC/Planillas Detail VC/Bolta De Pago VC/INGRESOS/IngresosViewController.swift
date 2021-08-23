//
//  IngresosViewController.swift
//  Oliver App IOS
//
//  Created by apple on 01/04/21.
//

import UIKit
import Firebase
import JGProgressHUD
class IngresosViewController: UIViewController {
    @IBOutlet var sueldoTF: UITextField!
    @IBOutlet var horasExtraTF: UITextField!
    @IBOutlet var asignacionTF: UITextField!
    @IBOutlet var remuneracionTF: UITextField!
    @IBOutlet var movTF: UITextField!
    @IBOutlet var ctsTF: UITextField!
    
    var company_Id = String()
   var worker_Id = String()



    override func viewDidLoad() {
        super.viewDidLoad()

    }
      @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func registerInfoBtnTapped(_ sender: Any) {
    
                    let dict = [
                      "sueldo": self.sueldoTF.text!,
                        "horas": self.horasExtraTF.text!,
                        "asign": self.asignacionTF.text!,
                        "remun" : self.remuneracionTF.text!,
                        "mov" : self.movTF.text!,
                        "cts": self.ctsTF.text!
                    ]
                    print(dict)
        UserDefaults.standard.setValue(dict, forKey: "INGRESOS")
        self.navigationController?.popViewController(animated: false)


          
         }
 
}
