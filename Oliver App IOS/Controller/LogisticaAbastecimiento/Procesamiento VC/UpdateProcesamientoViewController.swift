//
//  UpdateProcesamientoViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 21/02/21.
//

import UIKit
import JGProgressHUD
import Firebase


class UpdateProcesamientoViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var ordersProcessingKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
    }
    

    @IBAction func buttonCancel(_ sender: Any) {
        Database.database().reference().child("My Companies/\(companyId)").child("Orders Processing").child(ordersProcessingKey).updateChildValues([
            "order_processing_state" : "canceled",
        ])
        let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Nota de pedido Cancelada", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertView.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    @IBAction func buttonDispatch(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddProgramarDespachoVC") as! AddProgramarDespachoVC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    

    @IBAction func buttonback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
