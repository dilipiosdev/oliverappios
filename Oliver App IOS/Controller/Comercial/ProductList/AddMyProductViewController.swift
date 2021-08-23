//
//  AddMyProductViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 22/01/21.
//

import UIKit
import Firebase
import JGProgressHUD
class AddMyProductViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imgAddProduct: UIImageView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var txtAddMyProductPrice: UITextField!
    @IBOutlet weak var txtAddProductStock: UITextField!
    var companyDetailDict = DataSnapshot()
    var company_Ruc_String = String()
    var companyIDValue = String()
    var timeStampString = String()
    var matchView = String()
    var wareHouseID = String()
    let calender = Calendar.current
    let date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyIDValue = companyDetailDict.key
        company_Ruc_String = companyDetailDict.childSnapshot(forPath: "company_ruc").value as? String ?? ""
    }
    


/*******************************Add My Product ********************************************/
    @IBAction func buttonAddMyProduct(_ sender: Any) {
        if productName.text?.count == 0
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes in ingresar el nombre de tu producto.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        if txtAddMyProductPrice.text?.count == 0
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar el precio de tu producto.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        let timestamp = NSDate().timeIntervalSince1970
        timeStampString = String(format: "%.f",timestamp)
        let uid = String(format: "%@%@", companyDetailDict.key,timeStampString)
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let dateStr = String(format: "%d-%d-%d", components.year ?? 0 ,components.month ?? 0,components.day ?? 0)
        let dateTime = String(format: "%d-%d-%d", components.hour ?? 0 ,components.minute ?? 0,components.second ?? 0)
        
        
        let keyID = companyIDValue + timeStampString
        if matchView == "WareHouses" {
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Warehouses").child(wareHouseID).child("Products").child(keyID).updateChildValues(["company_id": companyIDValue,"product_currency": "PEN","product_description":"","product_measure": "quantity","product_name": productName.text ?? "","product_price": txtAddMyProductPrice.text ?? "0.00" ,"product_stock": String(format: "%@", txtAddProductStock.text ?? "0.00"),"security_stock_frequency": "","timestamp": timeStampString])
            
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Kardex").child(timeStampString).updateChildValues(["product_id": companyIDValue,"operation_date": dateStr,"operation_day": String(format: "%d", components.day ?? 0),"operation_month": String(format: "%d", components.month ?? 0),"operation_time": String(format: "%d", dateTime),"operation_type": "purchase" ,"operation_year": String(format: "%d", components.year ?? 0),"product_price": String(format: "%@", txtAddMyProductPrice.text ?? 0.00),"stock": String(format: "%@", txtAddProductStock.text ?? 0.00),"timestamp": timeStampString, "warehouse_destination_id": wareHouseID, "warehouse_origin_id": "store"])
        } else {
            Database.database().reference().child("My Companies/\(companyIDValue)").child("My Products").child(uid).updateChildValues(["code": company_Ruc_String,"company_id": company_Ruc_String,"product_currency": "PEN","product_description":"","product_measure": "quantity","product_name": productName.text ?? "","product_price": txtAddMyProductPrice.text ?? "0.00" ,"product_stock": String(format: "%@", txtAddProductStock.text ?? "0.00"),"security_stock_frequency": "","timestamp": timeStampString])
        }
        
        
        var data = NSData()
        data = imgAddProduct.image!.jpegData(compressionQuality: 0.8)! as NSData
        if(data.count > 0)
        {
            let storge = Storage.storage().reference().child("Product Images/").child(company_Ruc_String + timeStampString)
            storge.putData(data as Data, metadata: nil){ (metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else
                {
                    storge.downloadURL(completion: { [self] (url, error) in
                        if let urlText = url?.absoluteString
                        {
                            if self.matchView == "WareHouses" {
                                Database.database().reference().child("My Companies/\(self.companyIDValue)").child("Warehouses").child(self.wareHouseID).child("Products").child(keyID).updateChildValues(["product_image": urlText])
                                Database.database().reference().child("My Companies/\(self.companyIDValue)").child("Kardex").child(self.wareHouseID).updateChildValues(["product_image": urlText])
                                
                            } else {
                                Database.database().reference().child("My Companies/\(self.companyIDValue)").child("My Products").child(uid).updateChildValues(["product_image": urlText])
                            }
                            print("Successfull")
                        }
                    })
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /**************Add My Product **********/
    @IBAction func buttonCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.modalPresentationStyle = .popover
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func buttonGallery(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: { imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    imagePicker.modalPresentationStyle = .popover})
    }
    
    /************************* Image Picker Delegate  ****************************/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage]
        imgAddProduct.image = (chosenImage as! UIImage)
        picker.dismiss(animated: true, completion: nil)
        
        
        if(imgAddProduct.image?.size.width == nil)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes cargar uno foto de perfil correctamente.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        var data = NSData()
        data = imgAddProduct.image!.jpegData(compressionQuality: 0.8)! as NSData
        if(data.count > 0)
        {
            let timestamp = NSDate().timeIntervalSince1970
            timeStampString = String(format: "%.f",timestamp)
            
            let storge = Storage.storage().reference().child("Product Images/").child(company_Ruc_String + timeStampString)
            storge.putData(data as Data, metadata: nil){ (metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    hud.dismiss()
                    return
                }else
                {
                    storge.downloadURL(completion: { [self] (url, error) in
                        if let urlText = url?.absoluteString
                        {
                            hud.dismiss()
                            let uid = String(format: "%@%@", self.companyDetailDict.key,self.timeStampString)
                            Database.database().reference().child("My Companies/\(self.companyIDValue)").child("My Products").child(uid).updateChildValues(["product_image": urlText])
                            print("Successfull")
                        }
                    })
                }
            }
        }
        else
        {
            hud.dismiss()
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes cargar uno foto de perfil correctamente.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
        
    }
    
}


