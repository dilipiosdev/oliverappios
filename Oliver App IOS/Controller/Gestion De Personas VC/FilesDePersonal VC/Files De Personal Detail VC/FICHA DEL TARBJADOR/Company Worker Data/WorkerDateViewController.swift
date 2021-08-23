//
//  WorkerDateViewController.swift
//  Oliver App IOS
//
//  Created by apple on 16/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class WorkerDateViewController: UIViewController, UITableViewDelegate, addCalendarDelegate, TableListDelegate {
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    var currentYear = Int()
    @IBOutlet var paymentAmountTF: UITextField!
    @IBOutlet var paymentAmountCurLbl: UILabel!
    @IBOutlet var subventionTF: UITextField!
    @IBOutlet var hoursPerWeekTF: UITextField!
    @IBOutlet var labourTimeStartHrsLbl: UILabel!
    @IBOutlet var labourTimeStartMntLbl: UILabel!
    @IBOutlet var labourTimeEndHrsLbl: UILabel!
    @IBOutlet var labourTimeEndMntLbl: UILabel!
    
    @IBOutlet var lunchTimeStartHrsLbl: UILabel!
    @IBOutlet var lunchTimeStartMntLbl: UILabel!
    @IBOutlet var lunchTimeEndHrsLbl: UILabel!
    @IBOutlet var lunchTimeEndMntLbl: UILabel!
    
    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()
    var hourArray = Array<Any>()
    var minuteArray = Array<Any>()
    
    
    var localArray = Array<Any>()
    var lbrRegimenArray = Array<Any>()
    var workingTypeArray = Array<Any>()
    var contractTypeArray = Array<Any>()
    var paymentFrequencyArray = Array<Any>()
    var paymentTypArray = Array<Any>()
    
    
    var matchTable = String()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var subViewTable: UIView!
    @IBOutlet weak var tbl: UITableView!
    var timeStampString = String()
    var timeStr = String()
    var company_Id = String()
    var worker_Id = String()
    
    @IBOutlet var lbrRegimenBtn: UIButton!
    @IBOutlet var  workingTypeBtn: UIButton!
    @IBOutlet var contractTypeBtn: UIButton!
    @IBOutlet var  paymentFrequencyBtn: UIButton!
    @IBOutlet var paymentTypeBtn: UIButton!
    @IBOutlet var  solesBtn: UIButton!
    @IBOutlet var dolarsBtn: UIButton!
    
    var lbrRegimenStr = String()
    var  workingTypeStr = String()
    var contractTypeStr = String()
    var paymentFrequencyStr = String()
    var paymentTypStr = String()
    
    var  solesStr = String()
    var dolarsStr = String()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.lbrRegimenArray = ["DECRETO LEGISLATIVO N 728", "MICREOEMPRESA D.L. 1086", "PERSONAL EN FORMACION LABORAL", "OTROS"]
        self.workingTypeArray = ["EJECUTIVO", "OBRERO", "EMPLEADO", "CUARTA - QUINTA CATEGORIA", "PRACTICANTE PRE-PROFESIONAL", "PRACTICANTE PROFESIONAL"]
        self.contractTypeArray = ["A PLAZO INDETERMINADO", "A TIEMPO PARCIAL", "POR INICIO O INCREMENTO DE ACTIVIDAD", "POR NECESIDAD DEL MERCADO", "POR RECONVERSION EMPRESARIAL", "OCASIONAL", "DE SUPLENCIA", "DE EMERGENCIA", "PARA OBRA DETERMINADO O SERVICIO ESPECIFICO", "INTERMITENTE", "DE TEMPORADA", "DE EXPORTACION NO TRADICIONAL", "EXTRANJERO", "A DOMICILIO", "MIGRANTE ANDINO DECISION 545","CONVENIO DE PRACTICAS" ]
        self.paymentFrequencyArray = ["MENSUAL", "QUINCENAL", "SEMANAL", "OTROS"]
        self.paymentTypArray = ["EFECTIVO", "DEPOSITO EN CUENTA", "OTROS"]
        
        daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            yearArray.append(String(format: "%d",  currentYear - index))
        }
        
        self.hourArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","00"]
        
        self.minuteArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32" ,"33" ,"34" ,"35" ,"36" ,"37" ,"38" ,"39" ,"40" ,"41" ,"42" ,"43" ,"44" ,"45" ,"46" ,"47" ,"48" ,"49" ,"50" ,"51" ,"52" ,"53" ,"54" ,"55" ,"56" ,"57" ,"58" ,"59"]
        
        self.solesBtn.backgroundColor = UIColor.white
        self.dolarsBtn.backgroundColor = UIColor.white
        
    }
    
    
    @IBAction func buttonDate(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Date"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonMonth(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Month"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    @IBAction func buttonYear(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Year"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func solesbuttonTapped(_ sender: Any) {
        self.solesStr = "Soles"
        self.solesBtn.backgroundColor = UIColor.darkGray
        self.dolarsBtn.backgroundColor = UIColor.white
        
        
    }
    @IBAction func dolarsbuttonTapped(_ sender: Any) {
        self.dolarsStr = "Dolars"
        self.solesBtn.backgroundColor = UIColor.white
        self.dolarsBtn.backgroundColor = UIColor.darkGray
        
    }
    
    
    @IBAction func labourTimeStartHrTapped(_ sender: Any) {
        
        UserDefaults.standard.set("LTSH", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Hour"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func labourTimeStartMntTapped(_ sender: Any) {
        
        UserDefaults.standard.set("LTSM", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Minute"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func labourTimeEndHrsTapped(_ sender: Any) {
        UserDefaults.standard.set("LTEH", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Hour"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func labourTimeEndMntTapped(_ sender: Any) {
        
        UserDefaults.standard.set("LTEM", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Minute"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func lunchTimeStartHrTapped(_ sender: Any) {
        
        UserDefaults.standard.set("LUTSH", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Hour"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func lunchTimeStartMntTapped(_ sender: Any) {
        
        UserDefaults.standard.set("LUTSM", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Minute"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func lunchTimeEndHrsTapped(_ sender: Any) {
        UserDefaults.standard.set("LUTEH", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Hour"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func lunchTimeEndMntTapped(_ sender: Any) {
        
        UserDefaults.standard.set("LUTEM", forKey: "Common")
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Minute"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func lbrRegimenBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "LbrRegimen"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.lbrRegimenArray
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func workingTypeBtnTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "WorkingType"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.workingTypeArray
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func contractTypeBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "ContractType"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.contractTypeArray
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func paymentFrequencyBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "PaymentFrequency"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.paymentFrequencyArray
        self.present(nextViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func paymentTypeBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "PaymentType"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.paymentTypArray
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    
    func callTableViewList(match: String, value: String) {
        print("Match \(match)  Value \(value)")
        
        
        if(match == "LbrRegimen")
        {
            self.lbrRegimenStr = value
            self.lbrRegimenBtn.setTitle(self.lbrRegimenStr, for: .normal)
            return
        }
        
        if(match == "WorkingType")
        {
            self.workingTypeStr = value
            self.workingTypeBtn.setTitle(self.workingTypeStr, for: .normal)
            return
        }
        
        if(match == "ContractType")
        {
            self.contractTypeStr = value
            self.contractTypeBtn.setTitle(self.contractTypeStr, for: .normal)
            return
        }
        
        if(match == "PaymentFrequency")
        {
            self.paymentFrequencyStr = value
            self.paymentFrequencyBtn.setTitle(self.paymentFrequencyStr, for: .normal)
            return
        }
        
        if(match == "PaymentType")
        {
            self.paymentTypStr = value
            self.paymentTypeBtn.setTitle(self.paymentTypStr, for: .normal)
            return
        }
        
        
    }
    
    
    func callAddCalendar(match: String, value: String) {
        
       
        if(match == "Date")
        {
            lblDate.text = value
            return
        }
        if(match == "Month")
        {
            lblMonth.text = value
            return
        }
        if(match == "Year")
        {
            lblYear.text = value
            return
        }
        
            
            if let matchedValue = UserDefaults.standard.value(forKey: "Common") as? String {
               
            
            
            if(matchedValue == "LTSH")
                
            {
                labourTimeStartHrsLbl.text = value
                return
            }
            
            if(matchedValue == "LTSM")
            {
                
                labourTimeStartMntLbl.text = value
                return
            }
            
            if(matchedValue == "LTEH")
            {
                
                labourTimeEndHrsLbl.text = value
                return
            }
            
            
            if(matchedValue == "LTEM")
            {
                
                labourTimeEndMntLbl.text = value
                
                return
            }
            
            if(matchedValue == "LUTSH")
            {
                lunchTimeStartHrsLbl.text = value
                
                return
            }
            
            if(matchedValue == "LUTSM")
            {
                lunchTimeStartMntLbl.text = value
                
                return
            }
            
            if(matchedValue == "LUTEH")
            {
                lunchTimeEndHrsLbl.text = value
                return
            }
            
            if(matchedValue == "LUTEM")
            {
                lunchTimeEndMntLbl.text = value
                return
            }
            
        }
     
    }
    
    
    @IBAction func registerInfoBtnTapped(_ sender: Any) {
        
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        let dict:[AnyHashable : Any] = [
            "begin_working_day": self.lblDate.text!,
            "begin_working_month": self.lblMonth.text!,
            "begin_working_year": self.lblYear.text!,
            "payment_amount" : self.paymentAmountTF.text!,
            "subvention" : self.subventionTF.text!,
            "labour_time_start": "\(labourTimeStartHrsLbl.text!) : \(labourTimeStartMntLbl.text!)",
            "labour_time_end": "\(labourTimeEndHrsLbl.text!) : \(labourTimeEndMntLbl.text!)",
            "lunch_time_start":"\(lunchTimeStartHrsLbl.text!) : \(lunchTimeStartMntLbl.text!)",
            "lunch_time_end": "\(lunchTimeEndHrsLbl.text!) : \(lunchTimeStartMntLbl.text!)",
            "hours_per_week": self.hoursPerWeekTF.text!,
            "labour_regimen": self.lbrRegimenStr,
            "working_type": self.workingTypeStr,
            "contract_type": self.contractTypeStr,
            "payment_frequency": self.paymentFrequencyStr,
            "payment_type": self.paymentTypStr
            
        ]
        print(dict)
        Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
            .child(self.worker_Id).child("Personal File").child("Company Worker data").updateChildValues(dict)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}
