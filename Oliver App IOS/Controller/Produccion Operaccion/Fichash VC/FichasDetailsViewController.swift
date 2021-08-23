//
//  FichasDetailsViewController.swift
//  Oliver App IOS
//
//  Created by apple on 04/02/21.
//

import UIKit
import JGProgressHUD
import Firebase

class FichasDetailsViewController: UIViewController {
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var productName : UILabel!
    @IBOutlet weak var codigoLbl : UILabel!
    @IBOutlet weak var lblDes: UILabel!
    
    @IBOutlet weak var lblPropiedades: UILabel!
    @IBOutlet weak var meddidas: UILabel!
    @IBOutlet weak var lblNormas: UILabel!
    var objProduct = DataSnapshot()
    var objProductKey = String()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        let url = NSURL(string: String(format: "%@",objProduct.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        imageView.af.setImage(withURL: url! as URL, placeholderImage: image)
        productName.text = objProduct.childSnapshot(forPath: "product_name").value as? String ?? ""
        codigoLbl.text = "Codigo: " + (objProduct.childSnapshot(forPath: "code").value as? String ?? "")
        
    
        
        let hud = JGProgressHUD(style: .light)

        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Products").child(objProductKey)
        userRef.observe(.value) { (snapshot) in
            if let dic = snapshot.value as? Dictionary<String,Any>
            {
                
                self.lblDes.text =  String(format: "%@",dic["product_description"] as? String ?? "")
                self.lblPropiedades.text =  String(format: "%@",dic["product_specifications"] as? String ?? "")
                self.meddidas.text = String(format: "%@",dic["product_measurements"] as? String ?? "")
                self.lblNormas.text = String(format: "%@",dic["product_security_usage"] as? String ?? "")
            }
            else
            {
                hud.dismiss()
                
            }
        }
   
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn1(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFechaViewController") as! AddFechaViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.productKey = objProductKey
        nextViewController.titleStr = "Normas de Seguridad y Uso"
        nextViewController.tagValue = 0
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func btn2(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFechaViewController") as! AddFechaViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.productKey = objProductKey
        nextViewController.tagValue = 1

        nextViewController.titleStr = "Propiedades y Especificaciones"
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func btn3(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFechaViewController") as! AddFechaViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.productKey = objProductKey
        nextViewController.tagValue = 2
        nextViewController.titleStr = "Medidas"
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func btn4(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFechaViewController") as! AddFechaViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.tagValue = 3

        nextViewController.titleStr = "Normas de Seguridad y Uso"
        nextViewController.productKey = objProductKey
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
}
