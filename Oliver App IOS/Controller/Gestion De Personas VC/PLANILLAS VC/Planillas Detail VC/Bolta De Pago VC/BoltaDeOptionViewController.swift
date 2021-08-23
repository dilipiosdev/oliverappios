//
//  PerfileOptionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
import Firebase
import JGProgressHUD


class BoltaDeOptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, IngresosButtonProtocol, DesuentosButtonProtocol {
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var company_Id = String()
    var worker_Id = String()
    var personalFileArray = Array<Any>()
    var companyWorkerDataArray = Array<Any>()
    var birthDataArray = Array<Any>()
    var tableView = UITableView()
    var birthDataIndex: Int = 0
    var addressDataIndex: Int = 0
    var sueldo : Float = 0
    var descument : Float = 0
    var totalPayment : Float = 0
    let calender = Calendar.current
    let date = Date()
    var workerDataStr = String()
    var familiarDataStr = String()
    var topRadioSelectedStr = String()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.register(UINib(nibName: "BoltaDePagoTableViewCell", bundle: nil), forCellReuseIdentifier: "BoltaDePagoTableViewCell")
        
        tbl.register(UINib(nibName: "DatosDelTrabTableViewCell", bundle: nil), forCellReuseIdentifier: "DatosDelTrabTableViewCell")
        
        tbl.register(UINib(nibName: "IngresosTableViewCell", bundle: nil), forCellReuseIdentifier: "IngresosTableViewCell")
        
        tbl.register(UINib(nibName: "DescuentosTableViewCell", bundle: nil), forCellReuseIdentifier: "DescuentosTableViewCell")
        
        tbl.register(UINib(nibName: "AportacionesTableViewCell", bundle: nil), forCellReuseIdentifier: "AportacionesTableViewCell")
        
        tbl.register(UINib(nibName: "NetoTableViewCell", bundle: nil), forCellReuseIdentifier: "NetoTableViewCell")
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getBirthDataList()
        self.getCompanyWorkerDataList()
        print("In View will Appear")
        
    }
    
    
    //MARK:- UITableView Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BoltaDePagoTableViewCell", for: indexPath) as! BoltaDePagoTableViewCell
            let now = Date()
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "nl_NL")
            formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
            
            let datetime = formatter.string(from: now)
            
            cell.currentLastDayMonthYearLbl.text = "DEL \(datetime)/ AL  \(datetime) "
            
            let formatter1 = DateFormatter()
            formatter1.locale = Locale(identifier: "nl_NL")
            formatter1.setLocalizedDateFormatFromTemplate("yyyy/MM")
            let datetime1 = formatter1.string(from: now)
            
            cell.boletaDePagoLbl.text = "BOLETA DE PAGO - \(datetime1)"
            
            cell.company_social_reason.text = String(format: "%@", companyDetailDict.childSnapshot(forPath: "company_social_reason").value as? String ?? "")
            
            let companyImage1 = companyDetailDict.childSnapshot(forPath: "company_image").value as? String ?? ""
            let image:UIImage = UIImage(named: "back")!
            let url = NSURL(string: companyImage1)
            cell.imgCompany.af.setImage(withURL: url! as URL, placeholderImage: image)
            cell.imgCompany.layer.cornerRadius =  cell.imgCompany.frame.size.width/2
            
            cell.companyAddressLbl.text = companyDetailDict.childSnapshot(forPath: "company_address").value as? String ?? ""
            cell.companyRUCLbl.text = " RUC: \(companyDetailDict.childSnapshot(forPath: "company_ruc").value as? String ?? "")"
            
            cell.regimenBtn.addTarget(self, action: #selector(regimenBtnConnected(sender:)), for: .touchUpInside)
            
            cell.pequenaBtn.addTarget(self, action: #selector(pequenaBtnBtnConnected(sender:)), for: .touchUpInside)
            
            cell.microBtn.addTarget(self, action: #selector(microBtnBtnConnected(sender:)), for: .touchUpInside)
            
            if self.topRadioSelectedStr == "Regim" {
                cell.regimenBtn.backgroundColor =  UIColor.darkGray
                cell.pequenaBtn.backgroundColor =  UIColor.white
                cell.microBtn.backgroundColor =  UIColor.white
                
            }
            
            if self.topRadioSelectedStr == "Pequen" {
                cell.regimenBtn.backgroundColor =  UIColor.white
                cell.pequenaBtn.backgroundColor =  UIColor.darkGray
                cell.microBtn.backgroundColor =  UIColor.white
                
            }
            
            if self.topRadioSelectedStr == "Micro" {
                cell.regimenBtn.backgroundColor =  UIColor.white
                cell.pequenaBtn.backgroundColor =  UIColor.white
                cell.microBtn.backgroundColor =  UIColor.darkGray
            }
            cell.selectionStyle = .none
            
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatosDelTrabTableViewCell", for: indexPath) as! DatosDelTrabTableViewCell
            
            let day = self.companyWorkerDataArray[0] as! DataSnapshot
            let month = self.companyWorkerDataArray[1] as! DataSnapshot
            let year = self.companyWorkerDataArray[2] as! DataSnapshot
            let documentNo = self.birthDataArray[5] as! DataSnapshot
            
            cell.documentNumberLbl.text = "Documento: \(documentNo.value as? String ?? "")"
            
            cell.beginWorkingDMYLbl.text = "Fecha de Ingreso: \( day.value as? String ?? "")/\( month.value as? String ?? "")/\(year.value as? String ?? "")"
            
            if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                
                cell.jobProfileAreaLbl.text = "Area: \(dict["job_profile_area"]!)"
                cell.jobProfileJobNameLbl.text = "Cargo: \(dict["job_profile_job_name"]!)"
                
                cell.jobProfileJobNameLbl.text = "Apellidos y Nombers: \(dict["job_profile_name"]!) \(dict["job_profile_surname"]!)"
            }
            
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngresosTableViewCell", for: indexPath) as! IngresosTableViewCell
            
            let paymentAmt = self.companyWorkerDataArray[10] as! DataSnapshot
            if let dict = UserDefaults.standard.value(forKey: "INGRESOS") as? [String: String] {
                cell.sueldoLabel.text =
                "Sueldo: S/ \(dict["sueldo"]!)"
                cell.horasExtraLabel.text =  "Horas Extra: S/ \(dict["horas"]!)"
                
                cell.asignacionLabel.text = "Asignacion Familiar: S/ \( dict["asign"]!)"
                
                cell.remuneracionLabel.text = "Remuneracion Vacacional: S/ \(dict["remun"]!)"
                
                cell.movLabel.text =  "Mov. Sub. Asistencia: S/ \(dict["mov"]!)"
                
                cell.ctsLabel.text = "C.T.S: S/ \(dict["cts"]!)"
                
                let totalVAlue = (dict["sueldo"]! as NSString).floatValue + (dict["horas"]! as NSString).floatValue + (dict["asign"]! as NSString).floatValue + (dict["remun"]! as NSString).floatValue + (dict["mov"]! as NSString).floatValue + (dict["cts"]! as NSString).floatValue
                
                print(totalVAlue)
                cell.totalLabel.text = "Total Ingresos: S/ \(String(totalVAlue))"
                self.sueldo = totalVAlue
                                
            } else {
                
                cell.sueldoLabel.text = "Sueldo: S/ \(paymentAmt.value as? String ?? "")"
                cell.horasExtraLabel.text =  "Horas Extra: S/ 0.00"
                cell.asignacionLabel.text = "Asignacion Familiar:S/ 0.00"
                
                cell.remuneracionLabel.text = "Remuneracion Vacacional: S/ 0.00"
                cell.movLabel.text =  "Mov. Sub. Asistencia: S/ 0.00"
                
                cell.ctsLabel.text = "C.T.C: S/ 0.00"
                cell.totalLabel.text = "Total Ingresos: S/ \(paymentAmt.value as? String ?? "")"
                self.sueldo = (paymentAmt.value as! NSString).floatValue

            }
            
            cell.delegate = self
            
            return cell
            
        }
        
        if indexPath.row == 3 {
        
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescuentosTableViewCell", for: indexPath) as! DescuentosTableViewCell
            if let dict = UserDefaults.standard.value(forKey: "DESCUENTOS") as? [String: String] {
                let fondoFinalValue  = Float (self.sueldo *  (dict["afpFondo"]! as NSString).floatValue) / 100
                let commisionFinalValue  = Float (self.sueldo * (dict["afpCommision"]! as NSString).floatValue) / 100

                cell.afpFondoLbl.text = "AFP Fondo \((dict["afpFondo"]! as NSString))(%): S/ \(fondoFinalValue)"
                
                cell.afpCommisionLbl.text =  "AFP Comision \((dict["afpCommision"]! as NSString))(%): S/ \(commisionFinalValue)"
                
                cell.onpLbl.text = "ONP: S/ \( dict["onp"]!)"
                
                cell.fatlasLbl.text = "Fatlas: S/ \(dict["fatlas"]!)"
                
                cell.reten4taCatLbl.text =  "Retenciones 4ta Categoria: S/ \(dict["reten4taCat"]!)"
                
                cell.reten5taCatLbl.text = "Retenciones 5ta Categoria: S/ \(dict["reten5taCat"]!)"
                
                cell.retenJudicialLbl.text = "Retenciones Judiciales: S/ \( dict["retenJudicial"]!)"
                               
                cell.adelantosLbl.text = "Adelantos: S/ \(dict["adelantos"]!)"
                               
                
                let totalVAlue = fondoFinalValue + commisionFinalValue + (dict["onp"]! as NSString).floatValue + (dict["fatlas"]! as NSString).floatValue + (dict["reten4taCat"]! as NSString).floatValue + (dict["reten5taCat"]! as NSString).floatValue + (dict["retenJudicial"]! as NSString).floatValue + (dict["adelantos"]! as NSString).floatValue
                print(totalVAlue)
                cell.totalLbl.text = "Total Descuentos: S/ \(String(totalVAlue))"
                self.descument = totalVAlue

                
            } else {
                
               // let finalValue  = Float (self.sueldo * 100 / 10)

                cell.afpFondoLbl.text = "AFP Fondo 10.00%: S/ \(Float (self.sueldo * 10 / 100))"
                cell.afpCommisionLbl.text =  "AFP Commision 1.60%: S/ \(Float (self.sueldo * 1.60 / 100))"
                cell.onpLbl.text = "ONP:S/ 0.00"
                cell.fatlasLbl.text = "Fatlas: S/ 0.00"
                cell.reten4taCatLbl.text =  "Retenciones 4ta Categoria: S/ 0.00"
                cell.reten5taCatLbl.text = "Retenciones 5ta Categoria: S/ 0.00"
                cell.retenJudicialLbl.text = "Retenciones Judiciales: S/ 0.00"
                cell.adelantosLbl.text = "Adelantos: S/ 0.00"
                let totalValue = Float (self.sueldo * 10 / 100) + Float (self.sueldo * 1.60 / 100)
                cell.totalLbl.text = "Total Descuentos: S/\(String(totalValue))"
                self.descument = totalValue
            }
            cell.delegate = self
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AportacionesTableViewCell", for: indexPath) as! AportacionesTableViewCell
            cell.wsSaludLbl.text = "WsSalud 9%: S/ \(Float (self.sueldo * 9 / 100))"
            cell.totalAportesLbl.text =  "Total Aportes: S/ \(Float (self.sueldo * 9 / 100))"
            
            return cell
        }
        
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NetoTableViewCell", for: indexPath) as! NetoTableViewCell
            self.totalPayment = self.sueldo - self.descument
            
            cell.netoAPagarBtn.setTitle(" NETO A PAGAR: S/ \(self.sueldo - self.descument)", for: .normal)
            cell.registrarBoletaBtn.addTarget(self, action: #selector(regBoletaBtnConnected(sender:)), for: .touchUpInside)

            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 320
        }
        if indexPath.row == 1 {
            return 410
        }
        if indexPath.row == 2 {
            return 300
        }
        if indexPath.row == 3 {
            return 340
        }
        if indexPath.row == 4 {
            return 115
        }
        else {
            return 90
        }
    }
    
    
    //MARK:- Get Birth Data  List
    func getBirthDataList() -> Void {
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =  Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile").child(self.worker_Id).child("Personal File").child("Birth Data")
        //.child("Birth Data")
        
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.birthDataArray = array
                print("birthDataArray is \(self.birthDataArray)")
                self.tbl.delegate = self
                self.tbl.dataSource = self
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    //MARK:- Get Company Worker Data  List
    func getCompanyWorkerDataList() -> Void {
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =  Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile").child(self.worker_Id).child("Personal File").child("Company Worker Data")
        //.child("Birth Data")
        
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.companyWorkerDataArray = array
                print("companyWorkerDataArray is \(self.companyWorkerDataArray)")
                self.tbl.delegate = self
                self.tbl.dataSource = self
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    
    //MARK:- Other Income Data Delegate Methods
    func ingresosEditButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IngresosViewController") as! IngresosViewController
        self.navigationController?.pushViewController(nextViewController, animated: false)
        //self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    //MARK:- Other Income Data Delegate Methods
    func desuentosEditButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DescuentosViewController") as! DescuentosViewController
        nextViewController.checkRadio = self.topRadioSelectedStr
        self.navigationController?.pushViewController(nextViewController, animated: false)
        
    }
    
    @objc func regimenBtnConnected(sender: UIButton){
        self.topRadioSelectedStr = "Regim"
        self.tbl.reloadData()
        
    }
    
    @objc func pequenaBtnBtnConnected(sender: UIButton){
        self.topRadioSelectedStr = "Pequen"
        self.tbl.reloadData()
        
        
    }
    
    @objc func microBtnBtnConnected(sender: UIButton){
        self.topRadioSelectedStr = "Micro"
        self.tbl.reloadData()
        
    }
    
    @objc func regBoletaBtnConnected(sender: UIButton) {
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let timestamp = NSDate().timeIntervalSince1970
               let requestTimeStamp = String(format: "%.2f",timestamp)
               let timeStampString = String(format: "%.0f",timestamp)
               
               if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                   self.worker_Id = dict["Worker_Id"]!
                   self.company_Id = dict["Compnay_Id"]!
               }
        
               let dict:[AnyHashable : Any] = [
                   "operation_day": String(format: "%d", components.day ?? 0),
                   "operation_month": String(format: "%d", components.month ?? 0),
                   "operation_year": String(format: "%d", components.year ?? 0),
                   "total_payment" : String(self.totalPayment),
                   "worker_id" : self.worker_Id,
                   "bill_type": "work_sheet",
                   "bill_id": timeStampString,
                   "timestamp": requestTimeStamp
               ]
               print(dict)
        Database.database().reference().child("My Companies").child(self.company_Id).child("Worker Bills").child(timeStampString).updateChildValues(dict)
               
           }
           
       }
