//
//  PerfileOptionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
import Firebase
import JGProgressHUD


class FichasOptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BirthDataButtonProtocol, AddressDataButtonProtocol, EducationDataButtonProtocol, OtherIncomeButtonProtocol, CompanyWorkerDataButtonProtocol, FamiliarDataProtocol {
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var company_Id = String()
    var worker_Id = String()
    var personalFileArray = Array<Any>()
    var birthDataArray = Array<Any>()
    var addressDataArray = Array<Any>()
    var educationDataArray = Array<Any>()
    var otherIncomeDataArray = Array<Any>()
    var workerDataArray = Array<Any>()
    var familiarDataArray = Array<Any>()
    
    var tableView = UITableView()
    var birthDataIndex: Int = 0
    var addressDataIndex: Int = 0
    var educationDataIndex: Int = 0
    var otherIncomeDataIndex: Int = 0
    var workerDataIndex: Int = 0
    var familiarIndex: Int = 0
    
     var birthDataStr = String()
    var addressDataStr = String()
    var educationDataStr = String()
    var otherIncomeDataStr = String()
    var workerDataStr = String()
    var familiarDataStr = String()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        
        tbl.register(UINib(nibName: "BirthdataTableViewCell", bundle: nil), forCellReuseIdentifier: "BirthdataTableViewCell")
        
        tbl.register(UINib(nibName: "AddressdataTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressdataTableViewCell")
        
        tbl.register(UINib(nibName: "EducationdataTableViewCell", bundle: nil), forCellReuseIdentifier: "EducationdataTableViewCell")
        
        tbl.register(UINib(nibName: "SubTableCustomViewCell", bundle: nil), forCellReuseIdentifier: "SubTableCustomViewCell")
        
        tbl.register(UINib(nibName: "OtherIncomedataTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherIncomedataTableViewCell")
        
        tbl.register(UINib(nibName: "WorkerdataTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkerdataTableViewCell")
        
        self.getPersonalFileDateList()
    }
    
    
    
    //MARK:- UITableView Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.personalFileArray.isEmpty == false {
            if let obj = self.personalFileArray[indexPath.row] as? DataSnapshot {
                print("Keyyys...\(obj.key)")
                
                if obj.key == "Other Incomes" {
                    self.otherIncomeDataIndex = indexPath.row
                    self.otherIncomeDataStr = "Other Incomes"
                }
                
                if obj.key == "Address Data" {
                    self.addressDataIndex = indexPath.row
                    self.addressDataStr = "Address Data"
                }
                
                if obj.key == "Birth Data" {
                    self.birthDataIndex = indexPath.row
                    self.birthDataStr = "Birth Data"
                }
                if obj.key == "Company Worker Data" {
                    self.workerDataIndex = indexPath.row
                    self.workerDataStr = "Company Worker Data"
                }
                
                if obj.key == "Education Data" {
                    self.educationDataIndex = indexPath.row
                    self.educationDataStr = "Education Data"
                }
                
                if obj.key == "Familiars" {
                    self.familiarIndex = indexPath.row
                    self.familiarDataStr = "Familiars"
                }
                
                if obj.key == "Other Incomes" {
                    
                    self.otherIncomeDataIndex = indexPath.row
                    self.otherIncomeDataStr = "Other Incomes"
                }
            }
            
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                cell.jobProfileTitleLbl.text = dict["job_profile_name"]
                cell.jobNameLbl.text =  dict["job_profile_job_name"]
            }
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BirthdataTableViewCell", for: indexPath) as! BirthdataTableViewCell
            
            if self.birthDataStr == "Birth Data" {
                
                let obj = self.personalFileArray[self.birthDataIndex] as! DataSnapshot
                
                cell.nationalityLbl.text = "Nacionalidad: \( obj.childSnapshot(forPath: "nationality").value as? String ?? "")"
                
                cell.departmentLbl.text = "Departmento: \( obj.childSnapshot(forPath: "department").value as? String ?? "")"
                
                cell.provinceLbl.text = "Provincia: \( obj.childSnapshot(forPath: "province").value as? String ?? "")"
                
                cell.districtLbl.text = "Distrito: \( obj.childSnapshot(forPath: "district").value as? String ?? "")"
                cell.dobLbl.text = "Fecha de Nacimiento: \( obj.childSnapshot(forPath: "bth_day").value as? String ?? "")/\( obj.childSnapshot(forPath: "bth_month").value as? String ?? "")/\( obj.childSnapshot(forPath: "bth_year").value as? String ?? "")"
                cell.docTypeLbl.text = "Tipo de Documento: \( obj.childSnapshot(forPath: "document_type").value as? String ?? "")"
                cell.docNumberLbl.text = "N de Documento: \( obj.childSnapshot(forPath: "document_number").value as? String ?? "")"
                cell.delegate = self
            } else {
                
                cell.nationalityLbl.text = "Nacionalidad: \("Sin Información")"
                cell.departmentLbl.text = "Departmento: \("Sin Información")"
                cell.provinceLbl.text = "Provincia: \("Sin Información")"
                cell.districtLbl.text = "Distrito: \("Sin Información")"
                cell.dobLbl.text = "Fecha de Nacimiento: \("Sin Información")"
                cell.docTypeLbl.text = "Tipo de Documento: \("Sin Información")"
                cell.docNumberLbl.text = "N de Documento: \("Sin Información")"
                cell.delegate = self
            }
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressdataTableViewCell", for: indexPath) as! AddressdataTableViewCell
            
            if self.addressDataStr == "Address Data" {
                
                let obj = self.personalFileArray[self.addressDataIndex] as! DataSnapshot
                cell.addressLbl.text = "Direccion: \( obj.childSnapshot(forPath: "address").value as? String ?? "")"
                cell.addReferenceLbl.text = "Referencia: \( obj.childSnapshot(forPath: "address_reference").value as? String ?? "")"
                cell.fixedPhoneLbl.text = "Telefono Fijo: \( obj.childSnapshot(forPath: "fixed_phone").value as? String ?? "")"
                cell.mobilePhoneLbl.text = "Telefono Movil: \( obj.childSnapshot(forPath: "mobile_phone").value as? String ?? "")"
                cell.emailLbl.text = "Correo electronico: \( obj.childSnapshot(forPath: "email").value as? String ?? "")"
                cell.emergencyNameLbl.text = "Contacto de Emergencia: \( obj.childSnapshot(forPath: "emergency_contact_name").value as? String ?? "")"
                cell.emergencyContactLbl.text = "- N°: \( obj.childSnapshot(forPath: "emergency_contact_phone").value as? String ?? "")"
                cell.delegate = self
                
            } else {
                
                cell.addressLbl.text = "Direccion: \("Sin Información")"
                cell.addReferenceLbl.text = "Referencia: \("Sin Información")"
                cell.fixedPhoneLbl.text = "Telefono Fijo: \("Sin Información")"
                cell.mobilePhoneLbl.text = "Telefono Movil: \("Sin Información")"
                cell.emailLbl.text = "Correo electronico: \("Sin Información")"
                cell.emergencyNameLbl.text = "Contacto de Emergencia: \("Sin Información")"
                cell.emergencyContactLbl.text = "- N°:\("Sin Información")"
                cell.delegate = self
            }
            return cell
            
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EducationdataTableViewCell", for: indexPath) as! EducationdataTableViewCell
            
            if self.educationDataStr == "Education Data" {
                
                let obj = self.personalFileArray[self.educationDataIndex] as! DataSnapshot
                
                cell.academicDegreeLbl.text = "Grado Academico: \( obj.childSnapshot(forPath: "academic_degree").value as? String ?? "")"
                cell.institutionTypeLbl.text = "Tipo de Institucion: \( obj.childSnapshot(forPath: "institution_type").value as? String ?? "")"
                cell.institutionNameLbl.text = "Nombre de la Institucion: \( obj.childSnapshot(forPath: "institution_name").value as? String ?? "")"
                cell.degreeLbl.text = "Carrera: \( obj.childSnapshot(forPath: "degree").value as? String ?? "")"
                cell.outYearLbl.text = "Ano de Egreso: \( obj.childSnapshot(forPath: "out_year").value as? String ?? "")"
                cell.delegate = self
                
            } else {
                cell.academicDegreeLbl.text = "Grado Academico: \("Sin Información")"
                cell.institutionTypeLbl.text = "Tipo de Institucion: \("Sin Información")"
                cell.institutionNameLbl.text = "Nombre de la Institucion: \("Sin Información")"
                cell.degreeLbl.text = "Carrera: \("Sin Información")"
                cell.outYearLbl.text = "Ano de Egreso:\("Sin Información")"
                cell.delegate = self
            }
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubTableCustomViewCell", for: indexPath) as! SubTableCustomViewCell
            ///cell.familiarDataArray = self.familiarDataArray
            cell.delegate = self
            return cell
            
        }
        
        if indexPath.row == 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherIncomedataTableViewCell", for: indexPath) as! OtherIncomedataTableViewCell
            
            if self.otherIncomeDataStr == "Other Incomes" {
                
                let obj = self.personalFileArray[self.otherIncomeDataIndex] as! DataSnapshot
                cell.yesNoLbl.text = "Si"
                cell.otherincomeAmtLbl.text = "Importe: \( obj.childSnapshot(forPath: "other_income_amount").value as? String ?? "")"
                cell.otherincomeCompanyLbl.text = "Otro Empleador: \( obj.childSnapshot(forPath: "other_income_company").value as? String ?? "")"
                cell.otherincomeRUCLbl.text = "RUC: \( obj.childSnapshot(forPath: "other_income_ruc").value as? String ?? "")"
                cell.delegate = self
            } else {
                cell.yesNoLbl.text = "No"
                cell.otherincomeAmtLbl.text = "Importe: \("Sin Información")"
                cell.otherincomeCompanyLbl.text = "Otro Empleador: \("Sin Información")"
                cell.otherincomeRUCLbl.text = "RUC: \("Sin Información")"
                cell.delegate = self
            }
            return cell
        }
        
        if indexPath.row == 6 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerdataTableViewCell", for: indexPath) as! WorkerdataTableViewCell
            
            if self.workerDataStr == "Company Worker Data" {
                let obj = self.personalFileArray[self.workerDataIndex] as! DataSnapshot
                cell.beginWorkingLbl.text = "Fecha de Ingreso a Planilla: \( obj.childSnapshot(forPath: "begin_working_day").value as? String ?? "")/\( obj.childSnapshot(forPath: "begin_working_month").value as? String ?? "")/\( obj.childSnapshot(forPath: "begin_working_year").value as? String ?? "")"
                
                cell.paymentAmountLbl.text = "Remuneracion Bruta: \( obj.childSnapshot(forPath: "payment_amount").value as? String ?? "")"
                
                cell.subVentionLbl.text = "Subvencion Economica: \( obj.childSnapshot(forPath: "subvention").value as? String ?? "")"
                
                cell.lbrTimeStarEndLbl.text = "Haraio de Trabjo: \( obj.childSnapshot(forPath: "labour_time_start").value as? String ?? "") Hasta \( obj.childSnapshot(forPath: "labour_time_end").value as? String ?? "")"
                
                cell.lunchTimeStartEndLbl.text = "Haraio de Refrigerio: \( obj.childSnapshot(forPath: "lunch_time_start").value as? String ?? "") Hasta \( obj.childSnapshot(forPath: "lunch_time_end").value as? String ?? "")"
                
                cell.hoursPerWeekLbl.text = "Total Horas Semanales: \( obj.childSnapshot(forPath: "hours_per_week").value as? String ?? "")"
                
                cell.lbrRegimenLbl.text = "Regimen Laboral: \( obj.childSnapshot(forPath: "labour_regimen").value as? String ?? "")"
                
                cell.workingTypeLbl.text = "Tipo o Modalidad de Trabjo: \( obj.childSnapshot(forPath: "working_type").value as? String ?? "")"
                
                cell.contractTypeLbl.text = "Tipo de Contrato: \( obj.childSnapshot(forPath: "contract_type").value as? String ?? "")"
                
                cell.paymentFreqLbl.text = "Periodicidad de la Remuneracion: \( obj.childSnapshot(forPath: "payment_frequency").value as? String ?? "")"
                
                cell.paymentTypeLbl.text = "Tipo de Pago: \( obj.childSnapshot(forPath: "payment_type").value as? String ?? "")"
                
            } else {
                
                cell.beginWorkingLbl.text = "Fecha de Ingreso a Planilla: \("Sin Información")"
                
                cell.paymentAmountLbl.text = "Remuneracion Bruta: \("Sin Información")"
                
                cell.subVentionLbl.text = "Subvencion Economica: \("Sin Información")"
                
                cell.lbrTimeStarEndLbl.text = "Haraio de Trabjo: \("Sin Información")"
                cell.lunchTimeStartEndLbl.text = "Haraio de Refrigerio: \("Sin Información")"
                
                cell.hoursPerWeekLbl.text = "Total Horas Semanales: \("Sin Información")"
                
                cell.lbrRegimenLbl.text = "Regimen Laboral: \("Sin Información")"
                
                cell.workingTypeLbl.text = "Tipo o Modalidad de Trabjo: \("Sin Información")"
                
                cell.contractTypeLbl.text = "Tipo de Contrato: \("Sin Información")"
                
                cell.paymentFreqLbl.text = "Periodicidad de la Remuneracion: \("Sin Información")"
                
                cell.paymentTypeLbl.text = "Tipo de Pago: \("Sin Información")"
                
            }
            cell.delegate = self
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 125
        }
        if indexPath.row == 1 {
            return 301
        }
        if indexPath.row == 2 {
            return 301
        }
        if indexPath.row == 3 {
            return 230
        }
        if indexPath.row == 4 {
            return 208
        }
        if indexPath.row == 5 {
            return 192
        }
        else {
            return 410
        }
    }
    
    //MARK:- Get Worked List
    func getPersonalFileDateList() -> Void {
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =  Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile").child(self.worker_Id).child("Personal File")
        //.child("Birth Data")
        
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.personalFileArray = array
                print("personalFileArray is \(self.personalFileArray)")
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
    
    //MARK:- Birth Data Delegate Methods
    func birthEditButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BirthDateViewController") as! BirthDateViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    //MARK:- Address Data Delegate Methods
    func addressEditButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddressDateViewController") as! AddressDateViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    
    
    //MARK:- Address Data Delegate Methods
    func educationEditButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EducationDataViewController") as! EducationDataViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    //MARK:- Other Income Data Delegate Methods
    func otherIncomeButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtherIncomeDataViewController") as! OtherIncomeDataViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    //MARK:- Other Income Data Delegate Methods
    func companyWorkerEditButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "WorkerDateViewController") as! WorkerDateViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    //MARK:- Other Income Data Delegate Methods
    func familiarEditButtonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FamiliarDataViewController") as! FamiliarDataViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
}
