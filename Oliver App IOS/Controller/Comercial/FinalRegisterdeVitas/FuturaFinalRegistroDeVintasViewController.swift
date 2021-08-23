//
//  FinalRegistroDeVintasViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 04/01/21.
//

import UIKit
import Firebase
import AlamofireImage
import FirebaseStorage
import JGProgressHUD

class FuturaFinalRegistroDeVintasViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet var subViewTable: UIView!
    //BOB Arrays
    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()
    var localArray = Array<Any>()
    var countryArray = Array<Any>()
    var provincesArray = Array<Any>()
    var districsArray = Array<Any>()
    var activatedArray = Array<Any>()
    
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    var currentYear = Int()
    
    var selectCountry = Dictionary<String,Any>()
    var selectProvinces = Dictionary<String,Any>()
    var selectDistrics = Dictionary<String,Any>()
    
    var matchType = String()
    
    
    @IBOutlet var txtDepartmentoRegion: UITextField!
    @IBOutlet var txtEducatvo: UITextField!
    @IBOutlet var txtprovinciaDonde: UITextField!
    @IBOutlet var txtDistritoDonde: UITextField!
    
    @IBOutlet var subViewAddressTop: UIView!
    @IBOutlet var subViewAddressBottom: UIView!
    var creditType = String()

    
    
    var matchTable = String()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tbl: UITableView!
    var seleteNaivalStr = String()
    var companyChildValue = String()
    let timestamp = NSDate().timeIntervalSince1970
    var timeStampString = String()
    
    var dinNumberStr = String()
    var observationStr = String()
    var igvStr = String()
    var totalStr = String()
    var genderStr = String()
    var expirationDateStr = String()
    var sellerIDStr = String()
    var  arrayProductList = Array<Any>()
    var  bill_Id = String()
    
    var customerdDetails = DataSnapshot()
    let calender = Calendar.current
    let date = Date()
    var issuing_day = String()
    var issuing_month = String()
    var issuing_year = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.totalStr = ""
//        self.lblMonth.text = ""
//        igvStr = ""
//        observationStr = ""
//        genderStr = ""
//        lblDate.text = ""
//        lblMonth.text = ""
//        lblYear.text = ""
//        txtOcupassion.text = ""
//        txtDepartmento.text = ""
//        txtprovincia.text = ""
//        txtDistrito.text = ""
//        txtDepartmentoRegion.text = ""
//        txtprovinciaDonde.text = ""
//        txtDistritoDonde.text = ""
//        seleteNaivalStr = ""
//        issuing_day = ""
//        issuing_month = ""
//        issuing_year = ""
//        sellerIDStr = ""
//        timeStampString = ""
        
        
        subViewTable.isHidden = true
        timeStampString = String(format: "%.f",timestamp)

        /******************** Register Table Cell ****************************/
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
        daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            yearArray.append(String(format: "%d",  currentYear - index))
        }
    
        
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //DOB Buttons Actions
    @IBAction func buttonDate(_ sender: Any) {
        txtSearch.text = ""
        localArray = daysArray
        matchTable = "Date"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    @IBAction func buttonMonth(_ sender: Any) {
        //  txtSearch.text = ""
        localArray = monthArray
        matchTable = "Month"
        subViewTable.isHidden = false
        tbl.reloadData()
        
        
    }
    @IBAction func buttonYear(_ sender: Any) {
        // txtSearch.text = ""
        localArray = yearArray
        matchTable = "Year"
        subViewTable.isHidden = false
        tbl.reloadData()
        
    }
    
    /***** Nivel Educatvo*****/
    @IBAction func buttonEducatavo(_ sender: Any) {
        txtEducatvo.text = ""
        self.activatedArray.removeAll()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Economic Activities/")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value as! Dictionary<String,Any>)
            if let activated = snapshot.value as? Dictionary<String,Any>
            {
                self.activatedArray.removeAll()
                for (key, value) in activated {
                    let dict = activated[key] as! Dictionary<String,Any>
                    self.activatedArray.append(dict["name"] as! String)
                }
                hud.dismiss()
                print(activated)
                self.matchTable = "Activated"
               // self.activatedArray = activated
                self.subViewTable.isHidden = false
                self.localArray = self.activatedArray
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()

            }
        }
    }
    
    
    /***** Country*****/
    
    @IBAction func buttonDepartmentoRegion(_ sender: UIButton) {
        
        txtSearch.text = ""
        selectProvinces.removeAll()
        provincesArray.removeAll()
        selectDistrics.removeAll()
        districsArray.removeAll()
     
        if(sender.tag == 101)
        {
           self.matchTable = "Country"
           txtDepartmentoRegion.text = ""
           txtprovinciaDonde.text = ""
           txtDistritoDonde.text = ""
        }

        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Peru Locations").child("Departments")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let country = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(country)
                self.countryArray = country
                self.subViewTable.isHidden = false
                self.localArray = self.countryArray
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
                
            }
        }
       
    }
    
  
    
    /***** Provincia*****/
    
    @IBAction func buttonProvincioDomecile(_ sender: UIButton) {
        
        var countryId = String()
    
        if(sender.tag == 201)
        {
         if(selectCountry.isEmpty == true)
          {
            return
          }
          self.matchTable = "Provinces"
          txtSearch.text = ""
          txtprovinciaDonde.text = ""
          txtDistritoDonde.text = ""
          countryId = selectCountry["id_ubigeo"] as? String ?? "0"
        }
      
        selectDistrics.removeAll()
        districsArray.removeAll()
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Peru Locations").child("Provinces").child(countryId)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let districs = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(districs)
                self.provincesArray = districs
                self.subViewTable.isHidden = false
                self.localArray = self.provincesArray
                self.tbl.reloadData()
                
            }
            else
            {
                hud.dismiss()

            }
        }
    }
    @IBAction func buttontabelClose(_ sender: Any) {
        subViewTable.isHidden = true
    }
    
    /***** Distrito de Doicilllo del Cliente*****/
    
    @IBAction func buttonDistroDomecile(_ sender: UIButton) {
        
        var provincesId = String()
        if(sender.tag == 301)
        {
         if(selectProvinces.isEmpty == true)
          {
            return
          }
          self.matchTable = "Districs"
          txtSearch.text = ""
            txtDistritoDonde.text = ""
          provincesId = selectProvinces["id_ubigeo"] as? String ?? "0"

        }
      
        
        txtSearch.text = ""
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Peru Locations").child("Districs").child(provincesId)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let districs = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(districs)
                self.districsArray = districs
                self.subViewTable.isHidden = false
                self.localArray = self.districsArray
                self.tbl.reloadData()
                
            }
            else
            {
                hud.dismiss()

            }
        }
    }
    
    
    
    // Mark:- TableView Delegate Method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(matchTable == "Date")
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
        else if (matchTable == "Activated")
        {
            return activatedArray.count
            
        }
       
        else if (matchTable == "Country")
        {
            return countryArray.count
        }
       
        else if (matchTable == "Provinces")
        {
            return provincesArray.count
            
        }
        else if (matchTable == "Districs")
        {
            return districsArray.count
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RegisterTableViewCell = self.tbl.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as! RegisterTableViewCell
        cell.selectionStyle = .none
        cell.subViewSearch.layer.cornerRadius = 5
        cell.subViewSearch.clipsToBounds = true
        if(matchTable == "Date")
        {
            cell.lblText.text = daysArray[indexPath.row] as? String
            
        }
        else if(matchTable == "Month")
        {
            cell.lblText.text = monthArray[indexPath.row] as? String
            
        }
        else if(matchTable == "Year")
        {
            cell.lblText.text = String(format: "%@", yearArray[indexPath.row] as! String)
            
        }
        else if (matchTable == "Activated")
        {
            cell.lblText.text = String(format: "%@",  activatedArray[indexPath.row] as? String ?? "")
        }
       
        else if (matchTable == "Country")
        {
            let dict = countryArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
      
        else if (matchTable == "Provinces")
        {
            let dict = provincesArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
        
        else if (matchTable == "Districs")
        {
            let dict = districsArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(matchTable == "Date")
        {
            subViewTable.isHidden = true
            lblDate.text = daysArray[indexPath.row] as? String
           
            return
        }
        if(matchTable == "Month")
        {
            subViewTable.isHidden = true
            lblMonth.text = monthArray[indexPath.row] as? String
           
            return
        }
        if(matchTable == "Year")
        {
            
            subViewTable.isHidden = true
            lblYear.text = String(format: "%@",  yearArray[indexPath.row] as! String)
            
            return
        }
        if(matchTable == "Activated")
        {
            subViewTable.isHidden = true
            txtEducatvo.text = String(format: "%@",  activatedArray[indexPath.row] as? String ?? "")
            
            return
        }
       
        if(matchTable == "Country")
        {
            subViewTable.isHidden = true
            selectCountry = countryArray[indexPath.row] as! Dictionary<String,Any>
            txtDepartmentoRegion.text = String(format: "%@", selectCountry["nombre_ubigeo"] as? String ?? "")
            return
        }
        
        if(matchTable == "Provinces")
        {
            subViewTable.isHidden = true
            selectProvinces = provincesArray[indexPath.row] as! Dictionary<String,Any>
            txtprovinciaDonde.text = String(format: "%@", selectProvinces["nombre_ubigeo"] as! String)
        }
      
        if(matchTable == "Districs")
        {
            subViewTable.isHidden = true
            selectDistrics = districsArray[indexPath.row] as! Dictionary<String,Any>
            txtDistritoDonde.text = String(format: "%@", selectDistrics["nombre_ubigeo"] as! String)
            return
        }
}
    
    

    func getBillID() -> String{
   
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let bill_id = String(format: "%d%d%d%d%d%d",components.day!,components.month!,components.year!,components.hour!,components.minute!,components.second!)
        return bill_id
        
    }
    

    
    
    
    
    /*******************************Search *********************************/
    
    @IBAction func txtSearch(_ sender: Any) {
        if(matchTable == "Date")
        {
            self.daysArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.daysArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
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
            if(txtSearch.text!.count > 0)
            {
             
                self.monthArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
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
            if(txtSearch.text!.count > 0)
            {
             
                self.yearArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                yearArray = localArray
            }
        }
        
        if(matchTable == "Country")
        {
            self.countryArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                let searchPredicate = NSPredicate(format: "nombre_ubigeo CONTAINS[C] %@", txtSearch.text!)
                countryArray = (localArray as NSArray).filtered(using: searchPredicate)
            }
            else
            {
                countryArray = localArray
            }
        }
        if(matchTable == "Provinces")
        {
            self.provincesArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                let searchPredicate = NSPredicate(format: "nombre_ubigeo CONTAINS[C] %@", txtSearch.text!)
                provincesArray = (localArray as NSArray).filtered(using: searchPredicate)
            }
            else
            {
                provincesArray = localArray
            }
        }
        if(matchTable == "Districs") 
        {
            self.districsArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                let searchPredicate = NSPredicate(format: "nombre_ubigeo CONTAINS[C] %@", txtSearch.text!)
                districsArray = (localArray as NSArray).filtered(using: searchPredicate)
            }
            else
            {
                districsArray = localArray
            }
        }
        
       
        if(matchTable == "Activated")
        {
            self.activatedArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.activatedArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                activatedArray = localArray
            }
        }
        
        tbl.reloadData()
   }
    
    
    //MARK-: FINALIZER BUTTON ACTION

    @IBAction func finalizerBtnTapped(_ sender: Any) {
        
        if(lblDate.text?.isEmpty == true || lblMonth.text?.isEmpty == true || lblYear.text?.isEmpty == true || txtEducatvo.text?.isEmpty == true || txtDepartmentoRegion.text?.isEmpty == true  || txtprovinciaDonde.text?.isEmpty == true)
        {
            return
        }
        matchType = "Final"
        updateDB()
  }
    
    @IBAction func buttonOmitiry(_ sender: Any) {
        
        if(lblDate.text?.isEmpty == true || lblMonth.text?.isEmpty == true || lblYear.text?.isEmpty == true || txtEducatvo.text?.isEmpty == true || txtDepartmentoRegion.text?.isEmpty == true  || txtprovinciaDonde.text?.isEmpty == true)
        {
            return
        }
        matchType = ""
        updateDB()
    }
    
    func updateDB() -> Void {
        bill_Id = self.getBillID()
        let userRef =
            Database.database().reference()
       
        userRef.child("My Companies/\(companyChildValue)").child("Product Bill").observeSingleEvent(of: .value) { (snapshot) in
            if let array = snapshot.children.allObjects as? [DataSnapshot]
            {
                for i in 0 ..< array.count
                {
                    var productQuinityStr = ""
                    var productSalesStr = ""
                    let components = self.calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.date)

                    productQuinityStr = String(format: "%d%d",components.year!,components.month!)
                    productSalesStr = String(format: "%d%d",components.year!,components.month!)
                    let obj = array[i]
                    productQuinityStr = productQuinityStr + "quantity"
                    productSalesStr = productSalesStr + "sales"
                    Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).updateChildValues([
                        productQuinityStr : Double(obj.childSnapshot(forPath: "quantity").value as? String ?? "0.00") ?? 0.00,
                        productSalesStr : Double(obj.childSnapshot(forPath: "price").value as? String ?? "0.00") ?? 0.00
                    ])
                    
                    let quinityValue = Double(obj.childSnapshot(forPath: "quantity").value as? String ?? "0.00") ?? 0.00
                    Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).child("Buyers").child("Companies").child(self.bill_Id).updateChildValues([
                        "quantity_purchased" : quinityValue
                    ])
                    
                    Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).child("Sales Quantity").updateChildValues([
                        productQuinityStr : quinityValue,
                    ])
                    
                    
                    
                    Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).observeSingleEvent(of: .value, with: { (snapshot) in

                        if let districs = snapshot.value as? Dictionary<String,Any>
                        {
                            let mainStock = Double(districs["product_stock"] as? String ?? "0.00") ?? 0.00
                            let stockValue = Double(String(format: "%@",obj.childSnapshot(forPath: "quantity").value as? String ?? "0"))
                            let value = mainStock  - (stockValue ?? 0)
                            let valueStr = value
                            Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).updateChildValues([
                                "product_stock" :   String(format: "%.2f",valueStr)
                            ])
                        }
                    })
                }
            }
        }
        
       
        userRef.child("My Companies/\(companyChildValue)").child("Product Bill").observe(.value, with: { (snapshot) in
            userRef.child("My Companies/\(self.companyChildValue)").child("My Bills").child(self.bill_Id).child("Product List").setValue(snapshot.value)
            Database.database().reference().child("My Companies").child(self.companyChildValue).child("Product Bill").removeValue()
            self.updateMyBillMethod()
        })
    }

    
    func updateMyBillMethod() -> Void {
        
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let totalAmount = (Double(self.totalStr) ?? 0.00)

        var fullDateArr = expirationDateStr.split{$0 == "-"}.map(String.init)
        if(fullDateArr.count == 0)
        {
            expirationDateStr = String(format: "%d-%d-%d", day,month,year)
        }
        fullDateArr = expirationDateStr.split{$0 == "-"}.map(String.init)
        
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
        
        let customerNameStr = customerdDetails.childSnapshot(forPath: "customer_name").value as? String ?? ""
        let phoneStr = customerdDetails.childSnapshot(forPath: "customer_phone").value as? String ?? ""
        let customerEmailStr = customerdDetails.childSnapshot(forPath: "customer_email").value as? String ?? ""
        let customerIDStr = customerdDetails.key
        let components = self.calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: self.date)
        
        var stateStr = String()
        if(creditType == "CONTADO")
        {
            stateStr = "paid"
        }
        else if(creditType == "CREDITO")
        {
            stateStr = "no paid"
        }
        
        Database.database().reference().child("My Companies").child(companyChildValue).child("Customers")
            .child(customerIDStr).observeSingleEvent(of: .value, with: { (snapshot) in
                var totalPurchaseAmount = (Double(self.totalStr) ?? 0.00)
                let values = snapshot.value as? NSDictionary
                let purchased_total_amount_Value =  values?["purchased_total_amount"] as? Double ?? 0.00
                totalPurchaseAmount = purchased_total_amount_Value + totalAmount
                 Database.database().reference().child("My Companies").child(self.companyChildValue).child("Customers")
                    .child(customerIDStr).updateChildValues([
                    "purchased_total_amount" : totalPurchaseAmount
                ])
        })
        
        
        
        Database.database().reference().child("My Companies").child(companyChildValue).child("Customers")
            .child(customerIDStr).child("Purchased").child(bill_Id).updateChildValues([
            "bill_amount" : totalStr
        ])
        
        if(matchType == "Final")
        {
            Database.database().reference().child("My Companies").child(companyChildValue).child("My Bills").child(bill_Id).updateChildValues([
                "bill_amount": totalStr,
                "bill_currency": "PEN",
                "bill_id": bill_Id,
                "bill_igv_taxes": igvStr,
                "bill_observations": observationStr,
                "company_id": companyChildValue,
                "customer_document_numer": dinNumberStr,
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
                 "type" : "invoice",
                 "register_date" : String(format: "%d-%d-%d",components.day!,components.month!,components.year!) ,
                 "register_time" : String(format: "%d-%d-%d",components.hour!,components.minute!,components.second!)
            ])
         }
        
          
        self.dismiss(animated: true, completion: nil)


    }
}

