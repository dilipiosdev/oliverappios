//
//  AddQuinityViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 23/01/21.
//

import UIKit
import JGProgressHUD
import Firebase
protocol ProtocolDelegate: class {
    func popViewMethod()
}

class AddQuinityViewController: UIViewController {
    @IBOutlet weak var txtQuinity: UITextField!
    var stockValueStr = String()
    var addQuinityObj = DataSnapshot()
    @IBOutlet weak var imgQuinityProduct: UIImageView!
    @IBOutlet weak var lblQuinity: UILabel!
    
    let calendar = Calendar.current
    let date = Date()
    var day = Int()
    var month = Int()
    var year = Int()
    var timeStampString = String()
    var companyDetailDict = DataSnapshot()
    var companyIDValue = String()
    weak var delegateAddQuintity: ProtocolDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyIDValue = companyDetailDict.key
        lblQuinity.text = String(format: "Cantidad para %@",addQuinityObj.childSnapshot(forPath: "product_name").value as? String ?? "")
        let url = NSURL(string: String(format: "%@",addQuinityObj.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        stockValueStr = String(format: "%@",addQuinityObj.childSnapshot(forPath: "product_stock").value as? String ?? "0.00")
        imgQuinityProduct.af.setImage(withURL: url! as URL, placeholderImage: image)
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func buttonAddQuinity(_ sender: Any)
    {
        if(txtQuinity.text?.count ?? 0 > 0)
        {
            let stockQuinityValue = Float(stockValueStr) ?? 0
            let txtQuinityValue = Float(txtQuinity.text ?? "0") ?? 0
            if(stockQuinityValue > txtQuinityValue)
            {
                
                let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
                
                let timestamp = NSDate().timeIntervalSince1970
                timeStampString = String(format: "%.2f",timestamp)

                let childValue = String(format: "%@%@", companyDetailDict.childSnapshot(forPath: "uid").value as? String ?? "",timeStampString)
                
                let price = Double(addQuinityObj.childSnapshot(forPath: "product_price").value as? String ?? "0.00") ?? 0.00
                
                
                if price <= 0
                {
                    return
                }
                
                let totalValue = (Double(txtQuinity.text ?? "0") ?? 0.00) *  price
                Database.database().reference().child("My Companies").child(companyIDValue).child("Product Bill").child(addQuinityObj.key).updateChildValues([
                    "code": companyDetailDict.childSnapshot(forPath: "company_ruc").value as? String ?? "",
                    "discount": "0.00",
                    "measure": "quantity",
                    "name" : addQuinityObj.childSnapshot(forPath: "product_name").value as? String ?? "",
                    "price" : String(format: "%.2f", price),
                    "product_id":childValue,
                    "quantity" : txtQuinity.text ?? "0.00",
                    "total" : String(format: "%.2f",totalValue),
                    "timestamp" : timeStampString
                ])
                self.dismiss(animated: true, completion: {
                    self.delegateAddQuintity?.popViewMethod()

                })
            }
            else
            {
                let alertView: UIAlertController = UIAlertController(title: "", message: "No cuentas con stock suificiente.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertView.dismiss(animated: true, completion: nil)
                }
                alertView.addAction(alertAction)
                self.present(alertView, animated: true, completion: nil)
                return
            }
        }
        else
        {
            let alertView: UIAlertController = UIAlertController(title: "", message: "Please Enter Text", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
         
    }
    
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
