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
    
    var selectCountry1 = Dictionary<String,Any>()
    var selectProvinces1 = Dictionary<String,Any>()
    var selectDistrics1 = Dictionary<String,Any>()
    
    var arrayEduction = Array<Any>()
    
    @IBOutlet var txtDepartmento: UITextField!
    @IBOutlet var txtEducatvo: UITextField!
    @IBOutlet var txtOcupassion: UITextField!
    @IBOutlet var txtprovincia: UITextField!
    @IBOutlet var txtDistrito: UITextField!
    @IBOutlet var txtDepartmentoRegion: UITextField!
    @IBOutlet var txtprovinciaDonde: UITextField!
    @IBOutlet var txtDistritoDonde: UITextField!
    
    @IBOutlet var subViewAddressTop: UIView!
    @IBOutlet var subViewAddressBottom: UIView!
    
    @IBOutlet var txtCommericalName: UITextField!
    @IBOutlet var txtCompantydocumentNumber: UITextField!
    @IBOutlet var txtActivated: UITextField!
    
    
    var matchTable = String()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tbl: UITableView!
    var seleteNaivalStr = String()
    
    
    @IBOutlet weak var buttonMale: UIButton!
    @IBOutlet weak var buttonFemale: UIButton!
    var ocupationArray = Array<Any>()
    
    
    @IBOutlet weak var buttonMuy: UIButton!
    @IBOutlet weak var buttonBaje: UIButton!
    @IBOutlet weak var buttonMedip: UIButton!
    @IBOutlet weak var buttonAlto: UIButton!
    @IBOutlet weak var buutonMuyAlto: UIButton!
    
    
    var companyChildValue = String()
    let timestamp = NSDate().timeIntervalSince1970
    var timeStampString = String()
    
    var dinNumberStr = String()
    var observationStr = String()
    var igvStr = String()
    var totalStr = String()
    var genderStr = String()
    var emisionDateStr = String()
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
        
        
        ocupationArray = ["Abogado","Actor","Accionista","Artista","Director de Espectáculos","Administrador","Agente de Aduanas","Aeromozo","Agente de Bolsa","Agente de Turismo","Agricultor","Agrónomo","Analista de Sistemas","Antropólogo","Arqueólogo","Archivero","Armador de Barco","Arquitecto","Artesano","Asistente Social","Autor Literario","Avicultor","Bacteriólogo","Biólogo","Basurero","Cajero","Camarero","Cambista de Divisas","Campesino","Capataz","Cargador","Carpintero","Cartero","Cerrajero","Chef","Científico","Cobrador","Comerciante","Conductor","Conserje","Constructor","Contador","Contratista","Corredor Inmobiliario","Corredor de Seguros","Corte y Confección de Ropas","Cosmetólogo","Decorador","Dibujante","Dentista","Deportista","Distribuidor","Docente","Doctor - Medicina","Economista","Electricista","Empresario","Exportador","Importador","Inversionista","Enfermero","Ensamblador","Escultor","Estudiante","Fotógrafo","Gerente","Ingeniero","Jubilado","Maquinista","Mayorista","Mecánico","Médico","Miembro de las Fuerzas Armadas","Nutricionista","Obstetriz","Obrero de Construcción","Organizador de Eventos","Panadero","Pastelero","Paramédico","Periodista","Perito","Pescador","Piloto","Pintor","Policía","Productor de Cine","Programador","Psicólogo","Relojero","Rentista","Repartidor","Secretaría","Seguridad","Sociólogo","Tasador","rabajador Independiente","Trabajador Dependiente","Transportista","Veterinario","Visitador Medico","Zapatero"]
        
        
        arrayEduction = ["Educacion Inicial",
                         "Educacion Primaria",
                         "Educacion Secundaria",
                         "Educacion Superior Tecnica",
                         "Educacion Superior Universitaria",
                         "Maestria",
                         "Doctorado"]
        
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
        txtSearch.text = ""
        self.matchTable = "Educatavo"
        self.subViewTable.isHidden = false
        self.localArray = arrayEduction
        self.tbl.reloadData()
    }
    
    /***** Occupacian*****/
    
    @IBAction func buttonOccupacian(_ sender: Any) {
        
        txtSearch.text = ""
        self.matchTable = "Occupacian"
        self.subViewTable.isHidden = false
        self.localArray = self.ocupationArray
        self.tbl.reloadData()
        
    }
    
    /***** Country*****/
    
    @IBAction func buttonDepartmentoRegion(_ sender: UIButton) {
        
        txtSearch.text = ""
        selectProvinces.removeAll()
        provincesArray.removeAll()
        selectDistrics.removeAll()
        districsArray.removeAll()
        if(sender.tag == 100)
        {
          self.matchTable = "Country"
            txtDepartmento.text = ""
            txtprovincia.text = ""
            txtDepartmento.text = ""

        }
        if(sender.tag == 101)
        {
           self.matchTable = "Country1"
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
        if(sender.tag == 200)
        {
         if(selectCountry.isEmpty == true)
          {
            return
          }
          self.matchTable = "Provinces"
          txtSearch.text = ""
          txtprovincia.text = ""
          txtDistrito.text = ""
          countryId = selectCountry["id_ubigeo"] as? String ?? "0"

        }
        if(sender.tag == 201)
        {
         if(selectCountry1.isEmpty == true)
          {
            return
          }
          self.matchTable = "Provinces1"
          txtSearch.text = ""
          txtprovinciaDonde.text = ""
          txtDistritoDonde.text = ""
          countryId = selectCountry1["id_ubigeo"] as? String ?? "0"
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
    
    /***** Distrito de Doicilllo del Cliente*****/
    
    @IBAction func buttonDistroDomecile(_ sender: UIButton) {
        
        var provincesId = String()
        if(sender.tag == 300)
        {
         if(selectProvinces.isEmpty == true)
          {
            return
          }
          self.matchTable = "Districs"
          txtSearch.text = ""
          txtDistrito.text = ""
          provincesId = selectProvinces["id_ubigeo"] as? String ?? "0"

        }
        if(sender.tag == 301)
        {
          if(selectProvinces1.isEmpty == true)
          {
            return
          }
          self.matchTable = "Districs1"
          txtSearch.text = ""
          txtDistritoDonde.text = ""
          provincesId = selectProvinces1["id_ubigeo"] as? String ?? "0"
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
        else if (matchTable == "Educatavo")
        {
            return arrayEduction.count
            
        }
        else if (matchTable == "Occupacian")
        {
            return ocupationArray.count
            
        }
        else if (matchTable == "Country" || matchTable == "Country1")
        {
            return countryArray.count
        }
       
        else if (matchTable == "Provinces") || (matchTable == "Provinces1")
        {
            return provincesArray.count
            
        }
        else if (matchTable == "Districs") || (matchTable == "Districs1")
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
        else if (matchTable == "Educatavo")
        {
            cell.lblText.text = String(format: "%@",  arrayEduction[indexPath.row] as? String ?? "")
        }
        else if (matchTable == "Occupacian")
        {
            let str = ocupationArray[indexPath.row] as? String ?? ""
            cell.lblText.text = String(format: "%@",  str)
        }
        else if (matchTable == "Country") || (matchTable == "Country1")
        {
            let dict = countryArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
      
        else if (matchTable == "Provinces") || (matchTable == "Provinces1")
        {
            let dict = provincesArray[indexPath.row] as! Dictionary<String,Any>
            cell.lblText.text = String(format: "%@",  dict["nombre_ubigeo"] as! String)
        }
        
        else if (matchTable == "Districs") || (matchTable == "Districs1")
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
        if(matchTable == "Educatavo")
        {
            subViewTable.isHidden = true
            txtEducatvo.text = String(format: "%@",  arrayEduction[indexPath.row] as? String ?? "")
            
            return
        }
        if(matchTable == "Occupacian")
        {
            subViewTable.isHidden = true
            let str = ocupationArray[indexPath.row] as? String ?? ""
            txtOcupassion.text = String(format: "%@", str)
            return
        }
        if(matchTable == "Country")
        {
            subViewTable.isHidden = true
            selectCountry = countryArray[indexPath.row] as! Dictionary<String,Any>
            txtDepartmento.text = String(format: "%@", selectCountry["nombre_ubigeo"] as? String ?? "")
            return
        }
        if(matchTable == "Country1")
        {
            subViewTable.isHidden = true
            selectCountry1 = countryArray[indexPath.row] as! Dictionary<String,Any>
            txtDepartmentoRegion.text = String(format: "%@", selectCountry1["nombre_ubigeo"] as? String ?? "")
            return
        }
        if(matchTable == "Provinces")
        {
            subViewTable.isHidden = true
            selectProvinces = provincesArray[indexPath.row] as! Dictionary<String,Any>
            txtprovincia.text = String(format: "%@", selectProvinces["nombre_ubigeo"] as! String)
        }
        if(matchTable == "Provinces1")
        {
            subViewTable.isHidden = true
            selectProvinces1 = provincesArray[indexPath.row] as! Dictionary<String,Any>
            txtprovinciaDonde.text = String(format: "%@", selectProvinces1["nombre_ubigeo"] as! String)
        }
        if(matchTable == "Districs")
        {
            subViewTable.isHidden = true
            selectDistrics = districsArray[indexPath.row] as! Dictionary<String,Any>
            txtDistrito.text = String(format: "%@", selectDistrics["nombre_ubigeo"] as! String)
            return
        }
        if(matchTable == "Districs1")
        {
            subViewTable.isHidden = true
            selectDistrics1 = districsArray[indexPath.row] as! Dictionary<String,Any>
            txtDistritoDonde.text = String(format: "%@", selectDistrics1["nombre_ubigeo"] as! String)
            return
        }
        
        
        
        
    
    }
    
    

    func getBillID() -> String{
   
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let bill_id = String(format: "%d%d%d%d%d%d",components.day!,components.month!,components.year!,components.hour!,components.minute!,components.second!)
        return bill_id
        
    }
    
    
    @IBAction func buttonMale(_ sender: Any) {
        genderStr = "Hombre"
        buttonMale.backgroundColor = .blue
        buttonFemale.backgroundColor = .white
    }
    @IBAction func buttonFemale(_ sender: Any) {
        genderStr = "Mujer"
        buttonFemale.backgroundColor = .blue
        buttonMale.backgroundColor = .white
    }
    
    @IBAction func buttontabelClose(_ sender: Any) {
        subViewTable.isHidden = true
    }
  
    
    @IBAction func buttonMuy(_ sender: Any) {
        seleteNaivalStr = "Muy Bajo"
        buttonMuy.backgroundColor = .blue
        buttonBaje.backgroundColor = .white
        buttonMedip.backgroundColor = .white
        buttonAlto.backgroundColor = .white
        buutonMuyAlto.backgroundColor = .white
    
    }
    @IBAction func buttonBajo(_ sender: Any) {
        seleteNaivalStr = "Bajo"
        buttonMuy.backgroundColor = .white
        buttonBaje.backgroundColor = .blue
        buttonMedip.backgroundColor = .white
        buttonAlto.backgroundColor = .white
        buutonMuyAlto.backgroundColor = .white

    }
    @IBAction func buttonMedio(_ sender: Any) {
        seleteNaivalStr = "Medio"
        buttonMuy.backgroundColor = .white
        buttonBaje.backgroundColor = .white
        buttonMedip.backgroundColor = .blue
        buttonAlto.backgroundColor = .white
        buutonMuyAlto.backgroundColor = .white
    }
    
    
    @IBAction func buttonAlto(_ sender: Any) {
        seleteNaivalStr = "Alto"
        buttonMuy.backgroundColor = .white
        buttonBaje.backgroundColor = .white
        buttonMedip.backgroundColor = .white
        buttonAlto.backgroundColor = .blue
        buutonMuyAlto.backgroundColor = .white
    }
    @IBAction func buttomMuyAlto(_ sender: Any) {
        seleteNaivalStr = "Muy Alto"
        buttonMuy.backgroundColor = .white
        buttonBaje.backgroundColor = .white
        buttonMedip.backgroundColor = .white
        buttonAlto.backgroundColor = .white
        buutonMuyAlto.backgroundColor = .blue
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
        
        if(matchTable == "Country") || (matchTable == "Country1")
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
        if(matchTable == "Provinces") || (matchTable == "Provinces1")
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
        if(matchTable == "Districs") || (matchTable == "Districs1")
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
        
        if(matchTable == "Occupation")
        {
            self.ocupationArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.ocupationArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                ocupationArray = localArray
            }
        }
        if(matchTable == "Educatavo")
        {
            self.arrayEduction.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.arrayEduction.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                arrayEduction = localArray
            }
        }
        
        tbl.reloadData()
   }
    
    
    //MARK-: FINALIZER BUTTON ACTION

    @IBAction func finalizerBtnTapped(_ sender: Any) {
        
        if(lblDate.text?.isEmpty == true || lblMonth.text?.isEmpty == true || lblYear.text?.isEmpty == true || txtEducatvo.text?.isEmpty == true || txtOcupassion.text?.isEmpty == true || txtDepartmento.text?.isEmpty == true || txtDepartmentoRegion.text?.isEmpty == true || txtprovincia.text?.isEmpty == true || txtprovinciaDonde.text?.isEmpty == true || txtDistrito.text?.isEmpty == true || txtDepartmentoRegion.text?.isEmpty == true || seleteNaivalStr.isEmpty == true)
        {
            return
        }
        
        
        
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
                        productQuinityStr : String(format: "%@",obj.childSnapshot(forPath: "quantity").value as? String ?? ""),
                        productSalesStr : String(format: "%@",obj.childSnapshot(forPath: "price").value as? String ?? "")
                    ])
                    
                    
                    
                    Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).child("Sales Quantity").updateChildValues([
                        productQuinityStr : String(format: "%@",obj.childSnapshot(forPath: "quantity").value as? String ?? "0"),
                    ])
                    
                    
                    
                    Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).observeSingleEvent(of: .value, with: { (snapshot) in

                        if let districs = snapshot.value as? Dictionary<String,Any>
                        {
                           let mainStock = Int(String(format: "%@",(districs["product_stock"] as? String ?? "0")))
                           let stockValue = Int(String(format: "%@",obj.childSnapshot(forPath: "quantity").value as? String ?? "0"))
                            let value = (mainStock ?? 0) - (stockValue ?? 0)
                            let valueStr = String(format: "%d", value)
                            Database.database().reference().child("My Companies").child(self.companyChildValue).child("My Products").child(obj.key).updateChildValues([
                                "product_stock" : String(format: "%@", valueStr)
                                
                                
                                
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
        
        
        let fullDateArr = emisionDateStr.split{$0 == "-"}.map(String.init)
     
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
             "issuing_day": issuing_day,
             "issuing_month": issuing_month,
             "issuing_year":  issuing_year,
             "seller_id":  sellerIDStr,
             "state" : "paid" ,
             "timeStamp" : timeStampString ,
             "type" : "Bill",
             "register_date" : String(format: "%d-%d-%d",components.day!,components.month!,components.year!) ,
             "register_time" : String(format: "%d-%d-%d",components.hour!,components.minute!,components.second!)
        ])
        
       /* Database.database().reference().child("My Companies").child(companyChildValue).child("Customers")
            .child(customerIDStr).updateChildValues([
            "customer_email": customerEmailStr,
            "customer_gender": genderStr,
            "customer_bth_day": lblDate.text ?? "",
            "customer_bth_month": lblMonth.text ?? "",
            "customer_bth_year": lblYear.text ?? "",
            "customer_adademic_degree": txtEducatvo.text ?? "",
            "customer_occupation": txtOcupassion.text ?? "",
            "customer_department": txtDepartmento.text ?? "",
            "customer_province": txtprovincia.text ?? "",
            "customer_district": txtDistrito.text ?? "",
            "customer_work_department": txtDepartmentoRegion.text ?? "",
            "customer_work_province": txtprovinciaDonde.text ?? "",
            "customer_work_district": txtDistritoDonde.text ?? "",
            "customer_economic_level": seleteNaivalStr,
            "customer_phone" : phoneStr
        ])*/
        
          self.dismiss(animated: true, completion: nil)
    }
}

