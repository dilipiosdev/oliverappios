//
//  AddSoporteViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 24/01/21.
//

import UIKit
import JGProgressHUD
import Firebase


class AddSoporteViewController: UIViewController,ProtocolSendPointDelegate
{
    
    var companyDetailDict = DataSnapshot()
    var customerDetailDict = DataSnapshot()
    var companyIDValue = String()
    var customerIDValue = String()

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var txtFieldValue: UITextField!
    var matchType = String()
    var matchIndex = String()
    var customerName = String()
    var discountValueStr = String()
    var pointStr = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        companyIDValue = companyDetailDict.key
        if(matchType == "ASIGNAR")
        {
            lblTitle.text = "Asignar puntaje a \(customerName)"
            lblDes.text = "Ingresa Ios pintos acumulados por el cliente"
            txtFieldValue.placeholder = "Puntos..."
        }
        else if(matchType == "ENVIAR")
        {
            lblTitle.text = "Enviar descuento a \(customerName)"
            lblDes.text = "Ingresa el porcentaje de descuento para este cliente y envia un correo electronico como notificacion"
            txtFieldValue.placeholder = "Descuento (%)"
            txtFieldValue.text = discountValueStr
        }
        else if(matchType == "FRECUENCIA")
        {
            lblTitle.text = "Puntos:"
            lblDes.text = "Ingresa el numero de puntos que le daras a los clients que esten dentro del periodo seleccionado."
            txtFieldValue.placeholder = "Puntos..."
        }
        else if(matchType == "PUNTAJES")
        {
            lblTitle.text = "DESCUENTO:"
            lblDes.text = "Ingresa el porcentaje de descuento que le daras a los clients que esten dentro del rango seleccionado."
            txtFieldValue.placeholder = "Descuento (%)"
        }
    }
    
    @IBAction func buttonClose(_ sender: Any)
    {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonSend(_ sender: Any) {
        if(matchType == "ASIGNAR")
        {
          customerAsignarData()
        }
        else if(matchType == "ENVIAR")
        {
          let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SendPointsViewController") as! SendPointsViewController
          nextViewController.modalPresentationStyle = .overFullScreen
          nextViewController.companyDetailDict = companyDetailDict
          nextViewController.customerDetailDict = customerDetailDict
          nextViewController.pointStr = pointStr
          nextViewController.discountStr = txtFieldValue.text ?? ""
            nextViewController.delegateSendPoint = self
          self.present(nextViewController, animated: true, completion: nil)
        }
        else if(matchType == "FRECUENCIA")
        {
            frecuenciaData()
        }
        else if(matchType == "PUNTAJES")
        {
            puntajesData()
        }
    }
    func popSendPointViewMethod() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func customerAsignarData() -> Void {
        Database.database().reference().child("My Companies").child(companyIDValue).child("Customers").child(customerIDValue).updateChildValues([
            "customer_points" : String(format: "%@",txtFieldValue.text ?? "0")
        ])
        self.dismiss(animated: true, completion: nil)
    }
    
    func frecuenciaData() -> Void {
        let frecuenciaKey = String(format: "points%@", matchIndex)
        Database.database().reference().child("My Companies").child(companyIDValue).child("Module 6").child("Customer Points").child("Points").updateChildValues([
            frecuenciaKey : String(format: "%@",txtFieldValue.text ?? "0")
        ])
        self.dismiss(animated: true, completion: nil)
    }
    
    func puntajesData() -> Void {
        let puntajesKey = String(format: "discount%@", matchIndex)
        Database.database().reference().child("My Companies").child(companyIDValue).child("Module 6").child("Customer Points").child("Discounts").updateChildValues([
            puntajesKey : String(format: "%@",txtFieldValue.text ?? "0")
        ])
        self.dismiss(animated: false, completion: nil)
    }
}
