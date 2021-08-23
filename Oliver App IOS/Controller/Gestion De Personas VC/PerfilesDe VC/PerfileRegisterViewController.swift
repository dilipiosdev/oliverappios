//
//  PerfileRegisterViewController.swift
//  Oliver App IOS
//
//  Created by apple on 10/03/21.
//

import UIKit
import Firebase
import JGProgressHUD
class PerfileRegisterViewController: UIViewController, TableListDelegate  {
    
    
    var areaArray = Array<Any>()
    var denominationArray = Array<Any>()
    var jerarquicaArray = Array<Any>()
    var jerarquicaFunctionalArray = Array<Any>()
    var missionArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyID = String()

    
    var areaStr = String()
    var denominationStr = String()
    var jerarquicaStr = String()
    var jerarquicaFunctionalStr = String()
    var missionStr = String()
    var matchTable = String()
    
    @IBOutlet weak var selectiontbl: UITableView!
    @IBOutlet var subViewTable: UIView!
    @IBOutlet var perfileView: UIView!
    
    @IBOutlet var denominationBtn: UIButton!
     @IBOutlet var areaBtn: UIButton!
    @IBOutlet var jerarQBtn: UIButton!
     @IBOutlet var jerarFBtn: UIButton!
    @IBOutlet var missionBtn: UIButton!
    
    @IBOutlet var jobProfileNameTF: UITextField!
    @IBOutlet var jobProfileSurNameTF: UITextField!
    @IBOutlet var jobProfileJobNameTF: UITextField!
    @IBOutlet var jobProfilePeopleTF: UITextField!
    @IBOutlet var jobMissionTF: UITextField!
    @IBOutlet var jobMissionDescriptionTF: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
         self.companyID = companyDetailDict.key

        
        self.denominationArray = ["Practicante / Becario", "Operario/a", "Asistente administrativo/a", "Secretaria/o", "Recepcionista", "Comercial o Vendedor", "Analista", "Especialista", "Jefe de Area", "Gerente", "Directivo", "Presidente", "Socio"]
               
        self.areaArray = ["Junta Directiva", "Presidencia", "Direccion General", "Gerencia General", "Financiera y Contabilidad", "Administrativa", "Comercial y Ventas", "Recursos Humanos", "Produccion y Logistca", "Marketing", "Sistemas y Tecnologia", "Archivos centrales", "Compras", "Secretaria General"]
        
        self.jerarquicaArray = ["Junta Directiva", "Presidencia", "Director", "Director Financiera y Contabilidad", "Director Administrativa", "Director Comercial y Ventas", "Director Recursos Humanos", "Director Producción y Logística", "Director Marketing", "Director Sistemas y Tecnología", "Director Archivos centrales", "DirectorSecretaría General ", "Director Compras", "Gerente Financiera y Contabilidad", "Gerente Administrativa", "Gerente Comercial y Ventas", "Gerente Recursos Humanos", "Gerente Producción y Logística", "Gerente Marketing", "Gerente Sistemas y Tecnología", "Gerente Archivos centrales", "Gerente Secretaría General ", "Gerente Compras","Jefe Financiera y Contabilidad", "Jefe Administrativa", "Jefe Comercial y Ventas", "Jefe Recursos Humanos", "Jefe Producción y Logística", "Jefe Marketing", "Jefe Sistemas y Tecnología", "Jefe Archivos centrales", "Jefe Secretaría General ", "Jefe Compras","Encargado Financiera y Contabilidad", "Encargado Administrativa", "Encargado Comercial y Ventas", "Encargado Recursos Humanos", "Encargado Producción y Logística", "Encargado Marketing", "Encargado Sistemas y Tecnología", "Encargado Archivos centrales", "Encargado Secretaría General ", "Encargado Compras"]
        
          self.jerarquicaFunctionalArray = ["Junta Directiva", "Presidencia", "Dirección", "Dirección Financiera y Contabilidad", "Dirección Administrativa", "Dirección Comercial y Ventas", "Dirección Recursos Humanos", "Dirección Producción y Logística", "Dirección Marketing", "Dirección Sistemas y Tecnología", "Dirección Archivos centrales", "Dirección Secretaría General ", "Dirección Compras", "Gerencia Financiera y Contabilidad", "Gerencia Administrativa", "Gerencia Comercial y Ventas", "Gerencia Recursos Humanos", "Gerencia Producción y Logística", "Gerencia Marketing", "Gerencia Sistemas y Tecnología", "Gerencia Archivos centrales", "Gerencia Secretaría General ", "Gerencia Compras","Jefatura Financiera y Contabilidad", "Jefatura Administrativa", "Jefatura Comercial y Ventas", "Jefatura Recursos Humanos", "Jefatura Producción y Logística", "Jefatura Marketing", "Jefatura Sistemas y Tecnología", "Jefatura Archivos centrales", "Jefatura Secretaría General ", "Jefatura Compras"]
        
        self.missionArray = ["Realizar tareas y actividades operativas", "Realizar tareas y actividades de productivas", " Realizar tareas y actividades comerciales y de ventas", "Realizar tareas y actividades logísticas", "Realizar tareas y actividades de desarrollo software y tecnlogía", "Realizar tareas y actividades de asistencia administrativa", "Realizar tareas y actividades de secretaría", "Realizar tareas y actividades de elaboración y diseño creativos", "Realizar tareas y actividades de análisis", "Realizar tareas y actividades especializadas", "Realizar tareas y actividades de la jefatura asignada", "Realizar tareas y actividades de gerencia", "Realizar tareas y actividades de dirección", "Realizar tareas y actividades de presidencia" ]
        
    }
    
    
    @IBAction func denominationBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
                            nextViewController.modalPresentationStyle = .overFullScreen
                            nextViewController.matchTable = "Deno"
                            nextViewController.delegateTableList = self
                            nextViewController.commonArray =  self.denominationArray
                            self.present(nextViewController, animated: true, completion: nil)
        
        
      
        }
    
    @IBAction func areaBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
                                   nextViewController.modalPresentationStyle = .overFullScreen
                                   nextViewController.matchTable = "Area"
                                   nextViewController.delegateTableList = self
                                   nextViewController.commonArray =  self.areaArray
                                   self.present(nextViewController, animated: true, completion: nil)
      
           
           }
    
    @IBAction func jerarQBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
                                          nextViewController.modalPresentationStyle = .overFullScreen
                                          nextViewController.matchTable = "JerarQ"
                                          nextViewController.delegateTableList = self
                                          nextViewController.commonArray =  self.jerarquicaArray
                                          self.present(nextViewController, animated: true, completion: nil)
      
        }
    
    @IBAction func jerarFBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "JerarF"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.jerarquicaFunctionalArray
        self.present(nextViewController, animated: true, completion: nil)
       
           
           }
    
    @IBAction func missionBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
             let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
             nextViewController.modalPresentationStyle = .overFullScreen
             nextViewController.matchTable = "Mission"
             nextViewController.delegateTableList = self
             nextViewController.commonArray =  self.missionArray
             self.present(nextViewController, animated: true, completion: nil)
        
              
              }
    
    
    func callTableViewList(match: String, value: String) {
        
        if match == "Area" {
                   self.areaStr =  value
                   self.areaBtn.setTitle(self.areaStr, for: .normal)
               }
               if match == "Deno" {
                   self.denominationStr =  value
                   self.denominationBtn.setTitle(self.denominationStr, for: .normal)
               }
               
               if match == "JerarQ" {
                   self.jerarquicaStr =  value
                   self.jerarQBtn.setTitle(self.jerarquicaStr, for: .normal)
               }
               
               if match == "JerarF" {
                          self.jerarquicaFunctionalStr =  value
                          self.jerarFBtn.setTitle(self.jerarquicaFunctionalStr, for: .normal)
                      }
               
               if match == "Mission" {
                   self.missionStr =  value
                   self.missionBtn.setTitle(self.missionStr, for: .normal)
               }
    }
    
     
        @IBAction func registerPerfileBtn(_ sender: Any) {
           let timestamp = NSDate().timeIntervalSince1970
            let requestTimeStamp = String(format: "%.2f",timestamp)
            let timeStampString = String(format: "%.0f",timestamp)
            
            let dict:[AnyHashable : Any] =
                ["job_profile_name": self.jobProfileNameTF.text!,
                "job_profile_surname": self.jobProfileSurNameTF.text!,
                "job_profile_job_name": self.jobProfileJobNameTF.text!,
                "job_profile_area": self.areaStr,
                "job_profile_denomition": self.denominationStr,
                "job_profile_immediate_boss": self.jerarquicaStr,
                "job_profile_responsable_area": self.jerarquicaFunctionalStr,
                "job_profile_people_number": self.jobProfilePeopleTF.text!,
                "job_profile_job_mission": self.missionStr,
                "job_profile_job_mission_description": self.jobMissionDescriptionTF.text!,
                "timestamp": requestTimeStamp
            ]
            
            print(dict)
            Database.database().reference().child("My Companies").child(self.companyID).child("Job Profile").child(timeStampString).updateChildValues(dict)
            self.dismiss(animated: true, completion: nil)

    }
}
