//
//  IngresosViewController.swift
//  Oliver App IOS
//
//  Created by apple on 01/04/21.
//

import UIKit
import Firebase
import JGProgressHUD
class DescuentosViewController: UIViewController {
    @IBOutlet var afpFondoTF: UITextField!
    @IBOutlet var afpCommisionTF: UITextField!
    @IBOutlet var onpTF: UITextField!
    @IBOutlet var fatlasTF: UITextField!
    @IBOutlet var reten4taCatTF: UITextField!
    @IBOutlet var reten5taCatTF: UITextField!
    @IBOutlet var retenJudicialTF: UITextField!
    @IBOutlet var adelantosTF: UITextField!
    var company_Id = String()
    var worker_Id = String()
    var checkRadio = String()




    override func viewDidLoad() {
        super.viewDidLoad()
        if self.checkRadio == "Micro" {
            self.afpFondoTF.isEnabled = false
            self.afpCommisionTF.isEnabled = false
            self.onpTF.isEnabled = false
            self.afpFondoTF.text = "0.00"
            self.afpCommisionTF.text = "0.00"
            self.onpTF.text = "0.00"

            
 
        }

    }
      @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func registerInfoBtnTapped(_ sender: Any) {
    
                    let dict = [
                      "afpFondo": self.afpFondoTF.text!,
                        "afpCommision": self.afpCommisionTF.text!,
                        "onp": self.onpTF.text!,
                        "fatlas" : self.fatlasTF.text!,
                        "reten4taCat" : self.reten4taCatTF.text!,
                        "reten5taCat": self.reten5taCatTF.text!,
                        "retenJudicial" : self.retenJudicialTF.text!,
                        "adelantos": self.adelantosTF.text!
                    ]
                    print(dict)
        UserDefaults.standard.setValue(dict, forKey: "DESCUENTOS")
        self.navigationController?.popViewController(animated: false)


          
         }
 
}
