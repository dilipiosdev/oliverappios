//
//  AddTransferirViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 28/02/21.
//

import UIKit
import  JGProgressHUD
import Firebase
class AddTransferirViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var wareHousesKey = String()
    var imageURL = String()
    var stockValue = String()
    @IBOutlet weak var subViewAddStock: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lableProductTitle: UILabel!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var subViewStack: UIView!
    var matchView = String()
    override func viewDidLoad() {
        companyId = companyDetailDict.key
        subViewAddStock.isHidden = true
        super.viewDidLoad()
        let url = NSURL(string: String(format: "%@",imageURL))
        let image:UIImage = UIImage(named: "back")!
        productImage.af.setImage(withURL: url! as URL, placeholderImage: image)
        lableProductTitle.text = String(format: "Staock actual en almacen den EMO: %@", stockValue)
        if matchView == "WareHouses"
        {
            subViewStack.isHidden = true
            subViewAddStock.isHidden = false
        }
    }
    @IBAction func btn1(_ sender: Any) {
        subViewAddStock.isHidden = false
    }
    
    @IBAction func btn2(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "LogisticaAbastecimiento", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "WareHousesListViewController") as! WareHousesListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.wareHosesKey = wareHousesKey
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttoncloseTrafer(_ sender: Any) {
        if matchView == "WareHouses"
        {
          self.dismiss(animated: true, completion: nil)
        } else {
        subViewAddStock.isHidden = true
        }

    }
    @IBAction func buttonSubmit(_ sender: Any) {
        let stockV = Double(stockValue) ?? 0.00
        let textValue = Double(txtField.text ?? "0.00") ?? 0.00
        if (stockV > textValue)
        {
           Database.database().reference().child("My Companies/\(companyId)").child("Warehouses").child(wareHousesKey).child("Products").child(companyId).updateChildValues(["product_stock": String(format: "%.f", (stockV - textValue))])
        
           Database.database().reference().child("My Companies/\(companyId)").child("Kardex").child(wareHousesKey).updateChildValues(["product_stock": String(format: "%@.2f", (stockV - textValue))])
            self.dismiss(animated: true, completion: nil)
        }
        else {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Este monto sobrepasa tu stock actual.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
