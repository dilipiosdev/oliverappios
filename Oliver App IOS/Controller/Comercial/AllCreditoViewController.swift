//
//  AllCreditoViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 21/12/20.
//

import UIKit
import Firebase
import JGProgressHUD

class AllCreditoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var creditType = String()
    var buttonType = String()

    @IBOutlet weak var SubViewTopRUC: UIView!
    @IBOutlet weak var subViewISC: UIView!
    @IBOutlet weak var subViewDestnatario: UIView!
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var userListArray = Array<Any>()
    var myQuinityListArray = Array<Any>()
    
    @IBOutlet weak var subViewTop: UIView!
 
    var countryCode = String()

    var selectPersonaStr = String()
    var value = String()
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCompanySocialRegion: UILabel!
    @IBOutlet weak var lblCompany_RUC: UILabel!
    @IBOutlet weak var lblDestinatarioSelect: UILabel!
    @IBOutlet weak var lblObservation: UILabel!
    @IBOutlet weak var lblDINNumber: UILabel!
    @IBOutlet weak var txtRegisterDINNumber: UITextField!
    @IBOutlet weak var txtViewObserVation: UITextView!
    
    /*******************D.N.I number **************************/
    var updateDINNumberKey = String()
    var selectDinNumberStr = String()
    var selectIGVStr = String()
    @IBOutlet weak var lblTitle1DNI: UILabel!
    @IBOutlet weak var lbltitle2DNI: UILabel!
    var selectTotalStr = String()
    
    /****************Seller Addd*****/
    @IBOutlet weak var subViewSeller: UIView!
    @IBOutlet weak var tblSeller: UITableView!
    @IBOutlet weak var subViewSellerTop: UIView!

    
    @IBOutlet weak var subViewDIN: UIView!
    @IBOutlet weak var subViewObservation: UIView!
    @IBOutlet weak var buttonSellerList: UIButton!
    
   
    
    
    /*****************My Product Calculation***********/
    
    @IBOutlet weak var tblProductCalculation: UITableView!
    
    /*****************Sub View Add Quinity***********/

    var stockValueStr = String()
    var addQuinityObj = DataSnapshot()
    @IBOutlet weak var lblLGV: UILabel!
    @IBOutlet weak var lblMainTotal: UILabel!
    
    /***********************Date Calculter*****************/
    
    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()
    var currentYear = Int()
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    var localArray = Array<Any>()
    @IBOutlet weak var subViewDaysCal: UIView!
    @IBOutlet weak var subViewTable: UIView!
    @IBOutlet weak var tblDate: UITableView!
    var matchTable = String()
    @IBOutlet weak var lblShowDate: UILabel!
    @IBOutlet weak var lblEmisionDate: UILabel!
    var emisionDate = String()
    var expirationDate = String()

    var sellerIDStr = String()
    
    @IBOutlet weak var txtTableViewSearch: UITextField!
    
    /*****************Add My Product ***********/
    @IBOutlet weak var subViewAddMyProduct: UIView!
    @IBOutlet weak var imgAddProduct: UIImageView!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var txtAddMyProductPrice: UITextField!
    @IBOutlet weak var txtAddProductStock: UITextField!

    var company_Ruc_String = String()
    var selectobserVationStr = String()
    var selectCustomer = DataSnapshot()
    
    
    @IBOutlet weak var lblValorVenta: UILabel!
    var timeStampString = String()

    let calendar = Calendar.current
    let date = Date()
    var day = Int()
    var month = Int()
    var year = Int()
    
    var bill_Id = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        /***************Get Current Date ********************/
         day = calendar.component(.day, from: date)
         month = calendar.component(.month, from: date)
         year = calendar.component(.year, from: date)
        emisionDate = String(format: "%d-%d-%d",day,month,year)
        /***********************************************************/
        
        company_Ruc_String = companyDetailDict.childSnapshot(forPath: "company_ruc").value as? String ?? ""
        manageSubView()
        tableRegisaterCell()
        value = companyDetailDict.key
        selectPersonaStr = "Persona"
      
        manageView()
        setData()
        getQuinityProduct()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subViewDestnatario.isHidden = true
        subViewSeller.isHidden = true
   
        
        if(buttonType == "BOLETA")
        {
            lblShowDate.text = String(format: "VENTA AL CONTADO")
            lblDINNumber.text = String(format: "D.N.I COMPLETAR")
            lblTitle1DNI.text = "DNI"
            lbltitle2DNI.text = "Ingresa el D.N.I"
            txtRegisterDINNumber.placeholder = "D.N.I..."

        }
        else
        {
            lblShowDate.text = String(format: "VENCIMIENTO")
            lblDINNumber.text = String(format: "RUC DEL CLIENTE: COMPLETAR")
            
            lblTitle1DNI.text = "RUC DEL CLIENTE:"
            lbltitle2DNI.text = "Ingresa el RUC"
            txtRegisterDINNumber.placeholder = "RUC..."
        }
    }
    
    
    func setData() -> Void {
        lblAddress.text = companyDetailDict.childSnapshot(forPath: "company_address").value as? String ?? ""
        lblCompanySocialRegion.text = companyDetailDict.childSnapshot(forPath: "company_social_reason").value as? String ?? ""
        lblCompany_RUC.text = companyDetailDict.childSnapshot(forPath: "company_ruc").value as? String ?? ""
        
        //emisionDate = companyDetailDict.childSnapshot(forPath: "date").value as? String ?? ""
        lblEmisionDate.text = String(format: "EMISION: %@", emisionDate)
    }
    
    func manageSubView() -> Void {
        subViewDIN.isHidden = true
        subViewObservation.isHidden = true
        subViewSeller.isHidden = true
        daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            yearArray.append(String(format: "%d",  currentYear + index))
        }
    }
    
    func tableRegisaterCell() -> Void {
        tbl.register(UINib(nibName: "DestinatarioTableViewCell", bundle: nil), forCellReuseIdentifier: "DestinatarioTableViewCell")
        tblSeller.register(UINib(nibName: "DestinatarioTableViewCell", bundle: nil), forCellReuseIdentifier: "DestinatarioTableViewCell")

        tblProductCalculation.register(UINib(nibName: "ProductCalculationTVC", bundle: nil), forCellReuseIdentifier: "ProductCalculationTVC")
        tblDate.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
    }
    func manageView() -> Void {
        
        
        
        subViewTop.layer.cornerRadius = 5
        SubViewTopRUC.layer.borderWidth = 3
        SubViewTopRUC.layer.borderColor = UIColor.black.cgColor
        subViewISC.layer.borderWidth = 3
        subViewISC.layer.borderColor = UIColor.black.cgColor
        getCustomerList()
        subViewSellerTop.layer.cornerRadius = 5
        
    }
    /************************GET CUSTOMER List ************************************/
    func getCustomerList() -> Void {
        self.userListArray.removeAll()
        self.tbl.reloadData()
        matchTable = ""
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(value)").child("Customers")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.userListArray.removeAll()
                for item  in array {
                    let dict = item as! DataSnapshot
                    let uid = dict.childSnapshot(forPath: "customer_type").value as? String ?? ""
                    if(uid == "Persona" && self.buttonType == "BOLETA")
                    {
                        self.userListArray.append(dict)
                    }
                    else if(uid == "Empresa" && self.buttonType == "FACTURA")
                    {
                        self.userListArray.append(dict)
                    }
                }
                hud.dismiss()
                self.tbl.reloadData()
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
    
    @IBAction func buttonDestinatarion(_ sender: Any) {
        getCustomerList()
        subViewDestnatario.isHidden = false
    }
    @IBAction func buttonCloseSubView(_ sender: Any) {
        subViewDestnatario.isHidden = true
    }
    
    
    
    /***************Register *********************************/
    
    @IBAction func buttonRegisterDestinatarion(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCustomerViewController") as! AddCustomerViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(nextViewController, animated: true, completion: nil)
    }
   
    
    
    
    
    

    
    /****************Seller Coding***********************/
    
    @IBAction func buttonSellerList(_ sender: Any) {
        self.userListArray.removeAll()
        tbl.reloadData()
        matchTable = ""
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(value)").child("Sellers")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.userListArray.removeAll()
                self.userListArray = array
                hud.dismiss()
                self.tblSeller.reloadData()
                self.subViewSeller.isHidden = false
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    @IBAction func buttonAddSeller(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddSellerViewController") as! AddSellerViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func buttonCloseSellerView(_ sender: Any) {
        subViewSeller.isHidden = true
    }
    
 
    
    /****************Button Show DIN Number *******/
    @IBAction func buttonShowDINNumberView(_ sender: Any) {
        txtRegisterDINNumber.text = ""
        subViewDIN.isHidden = false
        subViewObservation.isHidden = true
        subViewSeller.isHidden = true
        
    }
    
    @IBAction func buttonObserVAtion(_ sender: Any) {
        txtViewObserVation.text = ""
        subViewDIN.isHidden = true
        subViewObservation.isHidden = false
        subViewSeller.isHidden = true
        
    }
    
    @IBAction func buttonCloseDIN(_ sender: Any) {
        subViewDIN.isHidden = true
        subViewObservation.isHidden = true
        subViewSeller.isHidden = true
        
    }
    @IBAction func buttonCloseObservation(_ sender: Any) {
        subViewDIN.isHidden = true
        subViewObservation.isHidden = true
        subViewSeller.isHidden = true
    }
    
    @IBAction func buttonRegisterDINNumber(_ sender: Any) {
        
        if(buttonType == "BOLETA")
        {
            lblDINNumber.text = String(format: "D.N.I:%@", txtRegisterDINNumber.text ?? "")
        }
        else
        {
            lblDINNumber.text = String(format: "RUC DEL CLIENTE: %@", txtRegisterDINNumber.text ?? "")
        }
        
        subViewDIN.isHidden = true
        subViewObservation.isHidden = true
        subViewSeller.isHidden = true
        selectDinNumberStr = txtRegisterDINNumber.text ?? ""
        if(updateDINNumberKey.isEmpty == false)
        {
            Database.database().reference().child("My Companies").child(value).child("Customers").child(updateDINNumberKey).updateChildValues([
                "customer_document_number" :  String(format: "%@", txtRegisterDINNumber.text ?? "")
            ])
        }
        
    }
    @IBAction func buttonRegisterObjervation(_ sender: Any) {
        selectobserVationStr = txtViewObserVation.text ?? ""
        lblObservation.text = String(format: "OBSERVACIONES:%@", txtViewObserVation.text ?? "")
        subViewDIN.isHidden = true
        subViewObservation.isHidden = true
        subViewSeller.isHidden = true
        txtViewObserVation.text = ""
        
    }
    
    /*******************My  Product List ********/
    @IBAction func buttonShowProductList(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllMyProductListViewController") as! AllMyProductListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
        
       
        
    }
    @IBAction func buttonCloseMyProduct(_ sender: Any) {
        subViewDIN.isHidden = true
        subViewObservation.isHidden = true
        subViewSeller.isHidden = true
    }
    /******************************** Quinity ********************************/
    func getQuinityProduct() -> Void {
        self.myQuinityListArray.removeAll()
        self.tblProductCalculation.reloadData()
        matchTable = ""
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let userRef =
            Database.database().reference().child("My Companies/\(value)").child("Product Bill")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.myQuinityListArray.removeAll()
                self.myQuinityListArray = array
                self.tblProductCalculation.reloadData()
                hud.dismiss()
                var total = Double()
                total = 0.00
                for i in 0 ..< self.myQuinityListArray.count
                {
                    let obj = self.myQuinityListArray[i] as! DataSnapshot
                    let totlaValue = Double(obj.childSnapshot(forPath: "total").value as? String ?? "0.00") ?? 0.00
                    total = total + totlaValue
                }
                self.lblMainTotal.text = String(format: "TOTLA: S/ %.2f", total)
                self.lblLGV.text = String(format: "IGV: S/ %.2f", total * 0.18)
                self.selectIGVStr = String(format: "%.2f", total * 0.18)
                self.selectTotalStr = String(format: "%.2f", total)
                if self.buttonType != "BOLETA" {
                    self.lblValorVenta.text = String(format: "VALOR VENTA: S/%.2f", (total - total * 0.18))
                    self.lblValorVenta.isHidden = false
                }
                else
                {
                    self.lblValorVenta.isHidden = true
                }
                
            }
            else
            {
                hud.dismiss()
            }
        }
        
    }
    

    /********************Date Calcultor *******/
    
    @IBAction func buutonShowSateView(_ sender: Any) {
        if(creditType == "CREDITO")
        {
            lblYear.text = "Año"
            lblMonth.text = "Mis"
            lblDays.text = "Dis"
            subViewDaysCal.isHidden = false
        }
    }
    @IBAction func buttonCloseDateView(_ sender: Any) {
        subViewDaysCal.isHidden = true
    }
    @IBAction func buttonDaysShow(_ sender: Any) {
        localArray.removeAll()
        tbl.reloadData()
        matchTable = ""
        txtTableViewSearch.text = ""
        localArray = daysArray
        matchTable = "Date"
        subViewTable.isHidden = false
        tblDate.reloadData()
    }
    @IBAction func buttonMonthShow(_ sender: Any) {
        localArray.removeAll()
        tbl.reloadData()
        matchTable = ""
        txtTableViewSearch.text = ""
        localArray = monthArray
        matchTable = "Month"
        subViewTable.isHidden = false
        tblDate.reloadData()
    }
    @IBAction func buttonYearShow(_ sender: Any) {
        localArray.removeAll()
        tbl.reloadData()
        matchTable = ""
        txtTableViewSearch.text = ""
        
        localArray = yearArray
        matchTable = "Year"
        subViewTable.isHidden = false
        tblDate.reloadData()
    }
    
    
    @IBAction func buttonCloseTableSubView(_ sender: Any) {
        subViewTable.isHidden = true
    }
    @IBAction func buttonDaysCalcultor(_ sender: Any) {
        
        if(lblYear.text?.count ?? 0 == 0 || lblYear.text == "Año")
        {
            return
        }
        if(lblMonth.text?.count ?? 0 == 0 || lblMonth.text == "Mis")
        {
            return
        }
        if(lblDays.text?.count ?? 0 == 0 || lblDays.text == "Dia")
        {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateA = dateFormatter.date(from: emisionDate)!
        
        let dateStrB = String(format: "%@-%@-%@",lblDays.text!,lblMonth.text!,lblYear.text!)
        emisionDate = dateStrB
        let dateB = dateFormatter.date(from: dateStrB)
        guard dateA != nil && dateB != nil else {
            return
        }
        expirationDate = dateStrB
        
        let diffInDays = Calendar.current.dateComponents([.day], from: dateA, to: dateB!).day
        if diffInDays ?? 0 >= 0
        {
            lblShowDate.text = String(format: "VENCIMIENTO: %@(%d dias)",dateStrB,diffInDays! )
        }
        subViewTable.isHidden = true
        subViewDaysCal.isHidden = true
        
    }
    
    
    @IBAction func txtSearch(_ sender: Any) {
        if(matchTable == "Date")
        {
            self.daysArray.removeAll()
            if(txtTableViewSearch.text!.count > 0)
            {
                
                self.daysArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtTableViewSearch.text!.uppercased())
                })
            }
            else
            {
                daysArray = localArray
            }
        }
        
        if(matchTable == "Month")
        {
            self.monthArray.removeAll()
            if(txtTableViewSearch.text!.count > 0)
            {
                self.monthArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtTableViewSearch.text!.uppercased())
                })
            }
            else
            {
                monthArray = localArray
            }
        }
        
        if(matchTable == "Year")
        {
            self.yearArray.removeAll()
            if(txtTableViewSearch.text!.count > 0)
            {
                
                self.yearArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtTableViewSearch.text!.uppercased())
                })
            }
            else
            {
                yearArray = localArray
            }
        }
        tblDate.reloadData()
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
    
    @IBAction func buttonShowAddMyProduct(_ sender: Any) {
        let timestamp = NSDate().timeIntervalSince1970
        timeStampString = String(format: "%.2f",timestamp)
        subViewAddMyProduct.isHidden = false
        
    }
    @IBAction func buttonCloseMyProductView(_ sender: Any) {
        subViewAddMyProduct.isHidden = true
    }
    
    
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
        Database.database().reference().child("My Companies/\(value)").child("My Products").child(uid).updateChildValues(["code": company_Ruc_String,"company_id": company_Ruc_String,"product_currency": "PEN","product_description":"","product_measure": "quantity","product_name": productName.text ?? "","product_price": txtAddMyProductPrice.text ?? "0.00" ,"product_stock": String(format: "%@", txtAddProductStock.text ?? "0.00"),"security_stock_frequency": "","timestamp": timeStampString])
        subViewAddMyProduct.isHidden = true
        
        
        
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
                            Database.database().reference().child("My Companies/\(self.value)").child("My Products").child(uid).updateChildValues(["product_image": urlText])
                            print("Successfull")
                        }
                    })
                }
            }
        }
        
    }
    /************************* Image Picker Delegate ****************************/
    
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
                            Database.database().reference().child("My Companies/\(self.value)").child("My Products").child(uid).updateChildValues(["product_image": urlText])
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
    
  
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }
    @IBAction func buttonFinalRegistroDeVintas(_ sender: Any) {
        
        if(selectDinNumberStr.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar el nombre de cliente ", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        } else if(selectobserVationStr.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes ingresar alguna observacion", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        else if(self.myQuinityListArray.count == 0)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes registrar un item en la boleta ", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        else if(sellerIDStr.isEmpty == true)
        {
            let alertView: UIAlertController = UIAlertController(title: title, message: "Debes registrar al vendedor de esta venta", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        else
        {
            let customer_obserVation = selectCustomer.childSnapshot(forPath: "customer_occupation").value as? String ?? ""
            let customer_id = selectCustomer.key
            
            if(customer_obserVation.count > 0 && customer_id.count > 0)
            {
                updateDB()
            }
            else
            if(buttonType == "BOLETA")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FinalRegistroDeVintasViewController") as! FinalRegistroDeVintasViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                nextViewController.companyChildValue = value
                nextViewController.dinNumberStr = selectDinNumberStr
                nextViewController.igvStr = selectIGVStr
                nextViewController.totalStr = selectTotalStr
                nextViewController.sellerIDStr = sellerIDStr
                nextViewController.observationStr = selectobserVationStr
                nextViewController.customerdDetails = selectCustomer
                nextViewController.expirationDateStr = expirationDate
                nextViewController.creditType = creditType
                self.present(nextViewController, animated: true, completion: nil)
           }
           else
           {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FuturaFinalRegistroDeVintasViewController") as! FuturaFinalRegistroDeVintasViewController
                nextViewController.modalPresentationStyle = .overFullScreen
                nextViewController.companyChildValue = value
                nextViewController.dinNumberStr = selectDinNumberStr
                nextViewController.igvStr = selectIGVStr
                nextViewController.totalStr = selectTotalStr
                nextViewController.sellerIDStr = sellerIDStr
                nextViewController.observationStr = selectobserVationStr
                nextViewController.customerdDetails = selectCustomer
                nextViewController.expirationDateStr = expirationDate
                nextViewController.creditType = creditType
                self.present(nextViewController, animated: true, completion: nil)
           }
        }
    }
    
    
    
    
    func updateDB() -> Void {
        bill_Id = self.getBillID()
        let totalAmount = (Double(self.selectTotalStr) ?? 0.00)
        let userRef =
            Database.database().reference()
        var buyerType = String()

        if(buttonType == "BOLETA")
        {
            buyerType = "Person"
        }
        else if(buttonType == "FACTURA")
        {
            buyerType = "Company"

        }
        userRef.child("My Companies/\(value)").child("Product Bill").observeSingleEvent(of: .value) {  (snapshot) in
            if let array = snapshot.children.allObjects as? [DataSnapshot]
            {
                for i in 0 ..< array.count
                {
                    var productQuinityStr = ""
                    var productSalesStr = ""
                    let components = self.calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.date)

                    productQuinityStr = String(format: "%d%d",components.year!,components.month!)
                    productSalesStr = String(format: "%d%d",components.year!,components.month!)
                    let obj = array[i]
                    productQuinityStr = productQuinityStr + "quantity"
                    productSalesStr = productSalesStr + "sales"
                    Database.database().reference().child("My Companies").child(self.value).child("My Products").child(obj.key).updateChildValues([
                        productQuinityStr : Double(obj.childSnapshot(forPath: "quantity").value as? String ?? "0.00") ?? 0.00,
                        productSalesStr : Double(obj.childSnapshot(forPath: "price").value as? String ?? "0.00") ?? 0.00
                    ])
                    
                    let quinityValue = Double(obj.childSnapshot(forPath: "quantity").value as? String ?? "0.00") ?? 0.00

                    Database.database().reference().child("My Companies").child(self.value).child("My Products").child(obj.key).child("Buyers").child(buyerType).child(self.bill_Id).updateChildValues([
                        "quantity_purchased" : quinityValue
                    ])
                    
                    Database.database().reference().child("My Companies").child(self.value).child("My Products").child(obj.key).child("Sales Quantity").updateChildValues([
                        productQuinityStr : quinityValue,
                    ])
                    
                    
                    
                    Database.database().reference().child("My Companies").child(self.value).child("My Products").child(obj.key).observeSingleEvent(of: .value, with: { (snapshot) in

                        if let districs = snapshot.value as? Dictionary<String,Any>
                        {
                            let mainStock = Double(districs["product_stock"] as? String ?? "0.00") ?? 0.00
                            let stockValue = Double(String(format: "%@",obj.childSnapshot(forPath: "quantity").value as? String ?? "0"))
                            let value = mainStock  - (stockValue ?? 0)
                            let valueStr = value
                            Database.database().reference().child("My Companies").child(self.value).child("My Products").child(obj.key).updateChildValues([
                                "product_stock" :  String(format: "%.2f",valueStr)
                            ])
                        }
                    })
                }
            }
        }
        
        let customerIDStr = selectCustomer.key
        userRef.child("My Companies").child(value).child("Customers")
            .child(customerIDStr).observeSingleEvent(of: .value, with: { (snapshot) in
                var totalPurchaseAmount = (Double(self.selectTotalStr) ?? 0.00)
                let values = snapshot.value as? NSDictionary

                let purchased_total_amount_Value =  values?["purchased_total_amount"] as? Double ?? 0.00
                totalPurchaseAmount = purchased_total_amount_Value + totalAmount
                 Database.database().reference().child("My Companies").child(self.value).child("Customers")
                    .child(customerIDStr).updateChildValues([
                    "purchased_total_amount" : totalPurchaseAmount
                ])
        })
        
        
        Database.database().reference().child("My Companies").child(value).child("Customers")
            .child(customerIDStr).child("Purchased").child(bill_Id).updateChildValues([
            "bill_amount" : selectTotalStr
        ])
        
        userRef.child("My Companies/\(value)").child("Product Bill").observeSingleEvent(of: .value, with: { (snapshot) in
            userRef.child("My Companies/\(self.value)").child("My Bills").child(self.bill_Id).child("Product List").setValue(snapshot.value)
            Database.database().reference().child("My Companies").child(self.value).child("Product Bill").removeValue()
            self.updateMyBillMethod()
        })
    }
    func updateMyBillMethod() -> Void {

        var fullDateArr = expirationDate.split{$0 == "-"}.map(String.init)
        if(fullDateArr.count == 0)
        {
            expirationDate = String(format: "%d-%d-%d", day,month,year)
        }
        fullDateArr = expirationDate.split{$0 == "-"}.map(String.init)
        var issuing_day = String()
        var issuing_month = String()
        var issuing_year = String()

        if(fullDateArr.count > 0 )
        {
            issuing_day = fullDateArr[0]
        }
        if(fullDateArr.count > 1 )
        {
            issuing_month = fullDateArr[1]
        }
        if(fullDateArr.count > 2)
        {
            issuing_year = fullDateArr[2]
        }
        
        let customerNameStr = selectCustomer.childSnapshot(forPath: "customer_name").value as? String ?? ""
        let phoneStr = selectCustomer.childSnapshot(forPath: "customer_phone").value as? String ?? ""
        let customerEmailStr = selectCustomer.childSnapshot(forPath: "customer_email").value as? String ?? ""
        let customerIDStr = selectCustomer.key
        
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        var stateStr = String()
        var stateType = String()

        if(creditType == "CONTADO")
        {
            stateStr = "Paid"
        }
        else if(creditType == "CREDITO")
        {
            stateStr = "No Paid"
            
        }
        if(buttonType == "BOLETA")
        {
            stateType = "bill"
        }
        else if(buttonType == "FACTURA")
        {
            stateType = "invoice"

        }
        
        if(Double(selectTotalStr) ?? 0.00 > 0)
        {
          Database.database().reference().child("My Companies").child(value).child("My Bills").child(self.bill_Id).updateChildValues([
            "bill_amount": selectTotalStr,
            "bill_currency": "PEN",
            "bill_id": self.bill_Id,
            "bill_igv_taxes": selectIGVStr,
            "bill_observations": selectobserVationStr,
            "company_id": value,
            "customer_document_numer": selectDinNumberStr,
            "customer_name": customerNameStr,
            "customer_id": customerIDStr,
            "issuing_day": String(format: "%d",day),
            "issuing_month": String(format: "%d",month),
            "issuing_year":  String(format: "%d",year),
            "expiration_day": issuing_day,
            "expiration_month": issuing_month,
            "expiration_year":  issuing_year,
            "seller_id":  sellerIDStr,
            "state" : stateStr ,
            "timeStamp" : timeStampString ,
            "type" : stateType,
            "register_date" : String(format: "%d-%d-%d",components.day!,components.month!,components.year!) ,
            "register_time" : String(format: "%d-%d-%d",components.hour!,components.minute!,components.second!)
          ])
        }
        self.dismiss(animated: true, completion: nil)
    }
    func getBillID() -> String{
        let date = Date()
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let bill_id = String(format: "%d%d%d%d%d%d",components.day!,components.month!,components.year!,components.hour!,components.minute!,components.second!)
        return bill_id
    }
}


//MARK:- TableView Methods
extension AllCreditoViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblProductCalculation)
        {
            return self.myQuinityListArray.count
        }
        else if(matchTable == "Date")
        {
            return  daysArray.count
        }
        else if(matchTable == "Month")
        {
            return  monthArray.count
        }
        else if(matchTable == "Year")
        {
            return  yearArray.count
        }
        if(tableView == tblSeller)
        {
            return self.userListArray.count
        }
        if(tableView == tbl)
        {
            return self.userListArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tblSeller)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DestinatarioTableViewCell", for: indexPath) as! DestinatarioTableViewCell
            let obj = self.userListArray[indexPath.row] as! DataSnapshot
            cell.lblName.text = obj.childSnapshot(forPath: "seller_name").value as? String ?? ""
            cell.lblNumber.text = String(format: "%@",obj.childSnapshot(forPath: "seller_phone").value as? String ?? "")
            cell.lblEmail.text = String(format: "%@",obj.childSnapshot(forPath: "seller_email").value as? String ?? "")
            cell.lblTipo.text = String(format: "%@",obj.childSnapshot(forPath: "seller_document_number").value as? String ?? "")
            cell.selectionStyle = .none
            return cell
        }
    
        else if(tableView == tblProductCalculation)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCalculationTVC", for: indexPath) as! ProductCalculationTVC
            let obj = self.myQuinityListArray[indexPath.row] as! DataSnapshot
            
            cell.selectionStyle = .none
            cell.lblQuinity.text = String(format: "%@",obj.childSnapshot(forPath: "quantity").value as? String ?? "")
            cell.lblCode.text = obj.childSnapshot(forPath: "code").value as? String ?? ""
            cell.lblStock.text = obj.childSnapshot(forPath: "name").value as? String ?? ""
            cell.lblPerPrice.text = String(format: "S/%@",obj.childSnapshot(forPath: "price").value as? String ?? "")
            
            cell.lblDiscount.text = String(format: "%@",obj.childSnapshot(forPath: "discount").value as? String ?? "")
            cell.lblTotal.text = String(format: "S/%@",obj.childSnapshot(forPath: "total").value as? String ?? "")
            cell.buttonCancel.addTarget(self,action:#selector(buttonCancelProduct),for:.touchUpInside)
            return cell
        }
        else if(matchTable == "Date")
        {
            let cell: RegisterTableViewCell = self.tblDate.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as! RegisterTableViewCell
            cell.lblText.text = daysArray[indexPath.row] as? String
            cell.selectionStyle = .none
            return cell
        }
        else if(matchTable == "Month")
        {
            let cell: RegisterTableViewCell = self.tblDate.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as! RegisterTableViewCell
            cell.lblText.text = monthArray[indexPath.row] as? String
            cell.selectionStyle = .none
            return cell
        }
        else if(matchTable == "Year")
        {
            let cell: RegisterTableViewCell = self.tblDate.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as! RegisterTableViewCell
            cell.lblText.text = String(format: "%@", yearArray[indexPath.row] as! String)
            cell.selectionStyle = .none
            return cell
            
        }
        else if(tableView == tbl)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DestinatarioTableViewCell", for: indexPath) as! DestinatarioTableViewCell
            let obj = self.userListArray[indexPath.row] as! DataSnapshot
            cell.lblName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
            cell.lblNumber.text = String(format: "Telefono: %@",obj.childSnapshot(forPath: "customer_phone").value as? String ?? "")
            cell.lblEmail.text = String(format: "Correo: %@",obj.childSnapshot(forPath: "customer_email").value as? String ?? "")
            cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
            cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
            cell.selectionStyle = .none
            cell.buttonDefinir.isHidden = true
            cell.buttonDefiniarConst.constant = 0
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DestinatarioTableViewCell", for: indexPath) as! DestinatarioTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == tbl)
        {
            let obj = self.userListArray[indexPath.row] as! DataSnapshot
            selectCustomer = obj
            lblDestinatarioSelect.text = String(format: "DESTINATARIO: %@",  obj.childSnapshot(forPath: "customer_name").value as? String ?? "")
            subViewDestnatario.isHidden = true
            selectDinNumberStr = obj.childSnapshot(forPath: "customer_document_number").value as? String ?? ""
            lblDINNumber.text = String(format: "%@", String(format: "D.N.I: %@",  obj.childSnapshot(forPath: "customer_document_number").value as? String ?? ""))
            updateDINNumberKey = obj.key
            
        }
        
    
        
        else if (tableView == tblSeller)
        {
            let obj = self.userListArray[indexPath.row] as! DataSnapshot
            let name = obj.childSnapshot(forPath: "seller_name").value as? String ?? ""
            buttonSellerList.setTitle(name, for: .normal)
            subViewSeller.isHidden = true
            sellerIDStr = obj.key
            GlobleClass.showToast(message: "Registrado", view: self.view, color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1).withAlphaComponent(0.6))
            //sellerIDStr =
        }
        else if(matchTable == "Date")
        {
            subViewTable.isHidden = true
            lblDays.text = daysArray[indexPath.row] as? String
            return
        }
        else if(matchTable == "Month")
        {
            
            subViewTable.isHidden = true
            lblMonth.text = monthArray[indexPath.row] as? String
            return
        }
        else if(matchTable == "Year")
        {
            
            subViewTable.isHidden = true
            lblYear.text = String(format: "%@",  yearArray[indexPath.row] as! String)
            return
        }
    }
    
    @objc func buttonCancelProduct(sender:UIButton) -> Void
    {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblProductCalculation)
        let indexPath = self.tblProductCalculation.indexPathForRow(at:buttonPosition)
        let obj = self.myQuinityListArray[indexPath!.row] as! DataSnapshot
        Database.database().reference().child("My Companies").child(value).child("Product Bill").child(obj.key).removeValue()
    }
    
}
extension AllCreditoViewController: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        countryCode = dialCode
        
        let x =  picker.getFlag(countryCode: code)
        
        if(code == "US")
        {
            
           // imgCountry1.image = UIImage(named: "US1.png")
           // lblCountryName1.text =  "United State"
            
        }
        let xxx =  picker.getDialCode(countryCode: code)
    }
}
