//
//  AgrumentariosViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 10/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AgrumentariosViewController: UIViewController {
    
    var saludoStr = String()
    var numberStr = String()
    var number1Str = String()
    var diferenciacionStr = String()
    var famousDePagoStr = String()
    var telStr = String()
    var horarioStr = String()
    
    @IBOutlet weak var lblDes: UILabel!
    var companyDetailDict = DataSnapshot()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblDes.text = String(format: "%@, mi nombre es %@ le de %@ y le contactamos porque quisiera presentarle nuestro %@ que estamos seguros que les va a interssar.\n\n\n Nuestro %@ se difererencia por %@ que  no lo tiene nuestra competencia. Sus pagos lo pueden realizar de lassiguientes formas: %@. Si lo requiere pregunte por nuestros multiples servicios. Pueden hacer sus pedidos por whatsapp al telefono:%@ en el siguiente horario: %@", saludoStr, numberStr  ,companyDetailDict.childSnapshot(forPath: "company_name").value as? String ?? "",number1Str,number1Str,diferenciacionStr,famousDePagoStr,telStr,horarioStr)
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
