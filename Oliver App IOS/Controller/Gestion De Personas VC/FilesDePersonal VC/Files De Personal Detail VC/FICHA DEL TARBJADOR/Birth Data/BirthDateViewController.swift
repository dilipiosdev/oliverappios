//
//  BirthDateViewController.swift
//  Oliver App IOS
//
//  Created by apple on 14/03/21.
//

import UIKit
import Firebase
import JGProgressHUD


class BirthDateViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate
, UITableViewDataSource, ADCountryPickerDelegate {
    @IBOutlet var lblCountryCode: UILabel!
    @IBOutlet var imgCountry: UIImageView!
    var countryCode = String()
    @IBOutlet weak var tbl: UITableView!
    var matchTable = String()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var subViewTable: UIView!
    
    
    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()
    var localArray = Array<Any>()
    var countryArray = Array<Any>()
    var provincesArray = Array<Any>()
    var districsArray = Array<Any>()
    var documentoArray = Array<Any>()
    
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    var currentYear = Int()
    
    var selectCountry = Dictionary<String,Any>()
    var selectProvinces = Dictionary<String,Any>()
    var selectDistrics = Dictionary<String,Any>()
    @IBOutlet var documentoTF: UITextField!
    @IBOutlet var countryBtn: UIButton!
    @IBOutlet var provinciaBtn: UIButton!
    @IBOutlet var  districtBtn: UIButton!
    @IBOutlet var documentoBtn: UIButton!
    
    var countryStr = String()
    var proviceStr = String()
    var districStr = String()
    var documentoStr = String()
    
    
    
    @IBOutlet var txtProv: UITextField!
    @IBOutlet var subViewAddressTop: UIView!
    @IBOutlet var subViewAddressBottom: UIView!
    @IBOutlet var txtDist: UITextField!
    
    @IBOutlet var txtCommericalName: UITextField!
    @IBOutlet var txtCompantydocumentNumber: UITextField!
    @IBOutlet var txtActivated: UITextField!
    
    var timeStampString = String()
    var timeStr = String()
    
    var company_Id = String()
       var worker_Id = String()
    
    override func viewDidLoad() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateStr = formatter.string(from: date)
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        timeStr = String(format: "%d:%d:%d", components.hour!,components.minute!,components.second!)
        let timeStrSave = String(format: "%d%d%d%%d%d%d%", components.year!,components.month!,components.day!,components.hour!,components.minute!,components.second!)
        let timestamp = NSDate().timeIntervalSince1970
        timeStampString = String(format: "%.f", timestamp)
        /******************** Register Table Cell ****************************/
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
        super.viewDidLoad()
        subViewTable.isHidden = true
        
        self.documentoArray = ["D.N.I", "Pasaporte", "Carnet de Extranjeria"]
        daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            yearArray.append(String(format: "%d",  currentYear - index))
        }
        self.subViewTable.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonContryCode(_ sender: Any) {
        let picker = ADCountryPicker(style: .grouped)
        picker.delegate = self
        picker.showCallingCodes = true
        picker.didSelectCountryClosure = { name, code in
            _ = picker.navigationController?.popToRootViewController(animated: true)
            print(code)
        }
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    
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
            else if (matchTable == "Documento")
            {
                return self.documentoArray.count
                
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
        else if (matchTable == "Documento")
        {
          
            cell.lblText.text = (self.documentoArray[indexPath.row] as! String)
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
        
        if(matchTable == "Country")
        {
            subViewTable.isHidden = true
            
            selectCountry = countryArray[indexPath.row] as! Dictionary<String,Any>
            self.countryStr = String(format: "%@", selectCountry["nombre_ubigeo"] as! String)
            self.countryBtn.setTitle(self.countryStr, for: .normal)
            return
        }
        
        if(matchTable == "Provinces")
        {
            subViewTable.isHidden = true
            selectProvinces = provincesArray[indexPath.row] as! Dictionary<String,Any>
            self.proviceStr = String(format: "%@", selectProvinces["nombre_ubigeo"] as! String)
            self.provinciaBtn.setTitle(self.proviceStr, for: .normal)
            return
        }
        
        if(matchTable == "Districs")
        {
            subViewTable.isHidden = true
            selectDistrics = districsArray[indexPath.row] as! Dictionary<String,Any>
            self.districStr = String(format: "%@", selectDistrics["nombre_ubigeo"] as! String)
            self.districtBtn.setTitle(self.districStr, for: .normal)
            return
        }
        
        
        if(matchTable == "Documento")
        {
            subViewTable.isHidden = true
            self.documentoStr = (self.documentoArray[indexPath.row] as? String)!
            self.documentoBtn.setTitle(self.documentoStr, for: .normal)
            return
        }
        
        
    }
    
    
    @IBAction func buttonSelectCountry(_ sender: Any) {
        txtSearch.text = ""
        selectProvinces.removeAll()
        provincesArray.removeAll()
        selectDistrics.removeAll()
        districsArray.removeAll()
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let userRef = Database.database().reference().child("Peru Locations").child("Departments")
        
        userRef.observe(.value) { (snapshot) in
            if let country = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(country)
                self.matchTable = "Country"
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
    @IBAction func buttonProvinces(_ sender: Any) {
        
        if(selectCountry.isEmpty == true)
        {
            return
        }
        txtSearch.text = ""
        selectDistrics.removeAll()
        districsArray.removeAll()
        
        let countryId = selectCountry["id_ubigeo"] as? String ?? "0"
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Peru Locations").child("Provinces").child(countryId)
        userRef.observe(.value) { (snapshot) in
            if let districs = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(districs)
                self.matchTable = "Provinces"
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
    @IBAction func buttonDistrics(_ sender: Any) {
        
        if(selectProvinces.isEmpty == true)
        {
            return
        }
        txtSearch.text = ""
        let provincesId = selectProvinces["id_ubigeo"] as? String ?? "0"
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("Peru Locations").child("Districs").child(provincesId)
        userRef.observe(.value) { (snapshot) in
            if let districs = snapshot.value as? Array<Any>
            {
                hud.dismiss()
                print(districs)
                self.matchTable = "Districs"
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
    
    @IBAction func buttonDocumento(_ sender: Any) {
        self.matchTable = "Documento"
        self.subViewTable.isHidden = false
       self.localArray = self.documentoArray
       self.tbl.reloadData()
        
        
    }
    
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
        tbl.reloadData()
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.subViewTable.isHidden = true
    }
    
    @IBAction func registerInfoBtnTapped(_ sender: Any) {
        
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                       self.worker_Id = dict["Worker_Id"]!
                       self.company_Id = dict["Compnay_Id"]!
                   }
        
                  let dict:[AnyHashable : Any] = [
                    "bth_day": self.lblDate.text!,
                      "bth_month": self.lblMonth.text!,
                      "bth_year": self.lblYear.text!,
                      "department" : self.countryStr,
                      "district" : self.districStr,
                      "document_number": self.documentoTF.text!,
                      "document_type": self.documentoStr,
                      "nationality": self.lblCountryCode.text!,
                      "province": self.proviceStr

                  ]
                  print(dict)
                Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
                      .child(self.worker_Id).child("Personal File").child("Birth Data").updateChildValues(dict)
                  self.dismiss(animated: true, completion: nil)
        
       }
}

extension BirthDateViewController {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        lblCountryCode.text = name + " (\(code))"
        countryCode = dialCode
        
        let x =  picker.getFlag(countryCode: code)
        imgCountry.image = x
        
        if(code == "US")
        {
            imgCountry.image = UIImage(named: "US1.png")
        }
        let xx =  picker.getCountryName(countryCode: code)
        let xxx =  picker.getDialCode(countryCode: code)
    }
}
