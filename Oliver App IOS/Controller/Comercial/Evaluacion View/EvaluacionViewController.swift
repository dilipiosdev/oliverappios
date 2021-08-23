//
//  EvaluacionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 25/01/21.
//

import UIKit
import Firebase
import JGProgressHUD

class EvaluacionViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    
    var companyDetailDict = DataSnapshot()
    var calificacionStr = String()
    var provienceStr = String()
    var addressTypeStr = String()
    var customerIDStr = String()
    var selectImageType = String()
    
    var dniUrl1 = String()
    var dniUrl2 = String()
    var dniUrl3 = String()


    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var btn33: UIButton!
    @IBOutlet weak var btn44: UIButton!
    @IBOutlet weak var btn55: UIButton!

    @IBOutlet weak var buttonSi1: UIButton!
    @IBOutlet weak var buttonNo1: UIButton!
    @IBOutlet weak var buttonSi11: UIButton!
    @IBOutlet weak var buttonNo22: UIButton!
    @IBOutlet weak var heightConst1: NSLayoutConstraint!
    @IBOutlet weak var heightConst2: NSLayoutConstraint!
    
    @IBOutlet weak var subViewSi1: UIView!
    @IBOutlet weak var subViewNo1: UIView!
    var companyIDValue = String()
    var customerIDValue = String()
    var customerName = String()

    @IBOutlet weak var txtMontoMax: UITextField!
    @IBOutlet weak var txtCuotas: UITextField!
    @IBOutlet weak var txtfrecuencia: UITextField!
    @IBOutlet weak var txtCuotaEstimada: UITextField!
    @IBOutlet weak var subView: UIView!
    var arrayList = Array<Any>()
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier: "RegisterTableViewCell")
        self.subView.isHidden = true

        heightConst1.constant = 70
        heightConst2.constant = 70
        subViewSi1.isHidden = true
        subViewNo1.isHidden = true
        companyIDValue = companyDetailDict.key
        arrayList = ["Diario","Semanal","Quincenal","Mensual"]
        
         dniUrl1 = ""
         dniUrl2 = ""
         dniUrl3 = ""
         
        lblTitle.text = String(format: "Evaluacion Interna para %@", customerName.uppercased())
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonCalifiacion(_ sender: UIButton) {
        btn1.backgroundColor = .white
        btn2.backgroundColor = .white
        btn3.backgroundColor = .white
        btn4.backgroundColor = .white
        btn5.backgroundColor = .white

        if sender.tag == 0{
            btn1.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            calificacionStr = "Normal"
        }
        else if sender.tag == 1{
            btn2.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            calificacionStr = "Problemas Potenciales"

        }
        else if sender.tag == 2{
            btn3.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            calificacionStr = "Deficiente"

        }
        else if sender.tag == 3{
            btn4.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            calificacionStr = "Dudoso"

        }
        else if sender.tag == 4{
            btn5.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            calificacionStr = "Perdida"

        }
        
    }
    
    @IBAction func buttonProvience(_ sender: UIButton) {
        btn11.backgroundColor = .white
        btn22.backgroundColor = .white
        btn33.backgroundColor = .white
        btn44.backgroundColor = .white
        btn55.backgroundColor = .white

        if sender.tag == 0{
            btn11.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            provienceStr = "Trabajador Dependiente"
        }
        else if sender.tag == 1{
            btn22.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            provienceStr = "Trabajador Independiente"
        }
        else if sender.tag == 2{
            btn33.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            provienceStr = "Rentista o Arrendador"
        }
        else if sender.tag == 3{
            btn44.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            provienceStr = "Negocio Propio"
        }
        else if sender.tag == 4{
            btn55.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            provienceStr = "Otros"
        }
        
    }

    
    @IBAction func buutonSi1(_ sender: Any) {
        buttonNo1.backgroundColor = .white
        buttonSi1.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        heightConst1.constant = 208
        subViewSi1.isHidden = false
        subViewNo1.isHidden = false
        addressTypeStr = "Si"
    }
    @IBAction func buttonNo1(_ sender: Any) {
        buttonNo1 .backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonSi1.backgroundColor = .white
        heightConst1.constant = 70
        heightConst1.constant = 70
        subViewSi1.isHidden = true
        subViewNo1.isHidden = true
        addressTypeStr = "No"
        dniUrl1 = ""
        dniUrl2 = ""
        image1.image = nil
        image2.image = nil

    }
    
    @IBAction func buttonSi2(_ sender: Any) {
    
        buttonNo22.backgroundColor = .white
        buttonSi11.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        heightConst2.constant = 208
        customerIDStr = "Si"

    }
    @IBAction func buttonNo2(_ sender: Any) {
        buttonSi11.backgroundColor = .white
        buttonNo22.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        heightConst2.constant = 70
        customerIDStr = "No"
        dniUrl3 = ""
        image3.image = nil

    }
    
    
    
    @IBAction func buttonSubmit(_ sender: Any) {

        Database.database().reference().child("My Companies").child(companyIDValue).child("Customers")
        .child(customerIDValue).child("Internal Evaluation").updateChildValues([
        "credit_scroe" : calificacionStr,
        "customer_address_verfication" : addressTypeStr,
        "customer_id_verfication" : customerIDStr,
        "customer_income_fund" : provienceStr,
        "customer_max_credit" : self.txtMontoMax.text ?? "",
        "customer_quotes_number" : self.txtCuotas.text ?? "",
        "customer_payment_frequency" : self.txtfrecuencia.text ?? "",
        "customer_quotes_amount" : self.txtCuotaEstimada.text ?? "",
        "customer_dni_1" : dniUrl1,
        "customer_dni_2" : dniUrl2,
        "customer_dni_3" : dniUrl3,
        ])
        self.dismiss(animated: true, completion: nil)
}
    
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    @IBAction func selectImage1(_ sender: Any) {
        selectImageType = "1"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func selectImage2(_ sender: Any) {
        selectImageType = "2"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)

    }
    @IBAction func selectImage3(_ sender: Any) {
        selectImageType = "3"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func buttonCloseSubView(_ sender: Any) {
        subView.isHidden = true
        
    }
    @IBAction func buttonSelectOption(_ sender: Any) {
        subView.isHidden = false
    }
    
    @IBAction func textChangeValue(_ sender: Any) {
        
        let value1 = Double(txtMontoMax.text ?? "0") ?? 0
        let value2 = Double(txtCuotas.text ?? "0") ?? 0
        txtCuotaEstimada.text = String(format: "%.2f", (value1 / value2))
    }
    /************************* Image Picker Delegate ****************************/

      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
      {
         
            let timestamp = NSDate().timeIntervalSince1970
            let timeStampString = String(format: "%.0f.jpg",timestamp)
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage]
            var data = NSData()
            if selectImageType == "1" {
                image1.image = (chosenImage as! UIImage)
                data = image1.image!.jpegData(compressionQuality: 0.8)! as NSData
            }
            else if selectImageType == "2" {
                image2.image = (chosenImage as! UIImage)
                data = image2.image!.jpegData(compressionQuality: 0.8)! as NSData
            }
            else if selectImageType == "3" {
                image3.image = (chosenImage as! UIImage)
                data = image3.image!.jpegData(compressionQuality: 0.8)! as NSData
            }
            let hud = JGProgressHUD(style: .light)
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            if(data.count > 0)
            {
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                
                let storge = Storage.storage().reference().child("Customer DNI/").child(appDelegate.userID + timeStampString)
                storge.putData(data as Data, metadata: metaData){ (metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    hud.dismiss()
                    return
                }else
                {
                    storge.downloadURL(completion: { [self] (url, error) in
                    if let urlText = url?.absoluteString
                    {
                        if self.selectImageType == "1" {
                            self.dniUrl1 = urlText
                        }
                        else if self.selectImageType == "2" {
                            self.dniUrl2 = urlText
                        }
                        else if self.selectImageType == "3" {
                            self.dniUrl3 = urlText
                        }
                      hud.dismiss()
                     
                    }
                 })
              }
          }
        }
            picker.dismiss(animated: true, completion: nil)
            if(image1.image?.size.width == nil)
            {
                let alertView: UIAlertController = UIAlertController(title: title, message: "Debes cargar uno foto de perfil correctamente.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertView.dismiss(animated: true, completion: nil)
                }
                alertView.addAction(alertAction)
                self.present(alertView, animated: true, completion: nil)
                return
            }
      }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated:  true, completion: nil)
    }
}



//MARK:- TableView Methods
extension EvaluacionViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterTableViewCell", for: indexPath) as! RegisterTableViewCell
        cell.lblText.text = String(format: "%@", arrayList[indexPath.row] as? String ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        txtfrecuencia.text = String(format: "%@", arrayList[indexPath.row] as? String ?? "")
        self.subView.isHidden = true

    }
}
