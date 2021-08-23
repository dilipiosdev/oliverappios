//
//  EducationDataViewController.swift
//  Oliver App IOS
//
//  Created by apple on 15/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class EducationDataViewController: UIViewController, TableListDelegate {
    @IBOutlet weak var selectiontbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var academicArray = Array<Any>()
    var institutionArray = Array<Any>()
    
    @IBOutlet var txtSearch: UITextField!
    var matchTable = String()
    var academicStr = String()
    var institutionStr = String()
    var company_Id = String()
    var worker_Id = String()
    
    @IBOutlet var academicBtn: UIButton!
    @IBOutlet var institutionBtn: UIButton!
    
    @IBOutlet var institutionNameTF: UITextField!
    @IBOutlet var degreeTF: UITextField!
    @IBOutlet var outYearTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.company_Id)
        
        self.academicArray = ["SIN EDUCACION FORMAL", "EDUCACION SPECIAL INCOMPLETA", "EDUCACION SPECIAL COMPLETA", "EDUCACION PRIMARIA INCOMPLETA", "EDUCACION PRIMARIA COMPLETA", "EDUCACION SECUNDARIA INCOMPLETA", "EDUCACION SECUNDARIA COMPLETA", "EDUCACION TECNICA INCOMPLETA", "EDUCACION TECNICA COMPLETA", "EDUCACION SUP.(INSTITUTO SUPERIOR, ETC. INCOMPLETA)", "EDUCACION SUP.(INSTITUTO SUPERIOR, ETC. COMPLETA)", "EDUCACION UINVERSITARIA INCOMPLETA", "EDUCACION UINVERSITARIA COMPLETA", "GRADO BACHILLER", "TITULADO", "EDUCACION MAESTRIA INCOMPLETA", "EDUCACION MAESTRIA COMPLETA", "GRADO DE MAESTRIA", "ESTUDIO DE DOCTORADO INCOMPLETO", "ESTUDIO DE DOCTORADO COMPLETO", "GRADO DE DOCTOR"]
        
        self.institutionArray = ["ESCULAS E INSTITUTOS DE EDUCACION SUPERIOR,TECHNOLOGICOS DE LAS FUERZAS ARMADAS Y POLICIALES", "EDUCACION SUPERIOR DE FORMACION ARTISTICA", "INSTITUTO SUPERIOR PEDAGOGICO", "INSTITUTOS DE EDUCACION SUPERIOR TECHNOLOGICOS (IEST)", "UNIVERSIDAD", "NO ESPECIFICADO"]
    }
    
    func callTableViewList(match: String, value: String) {
        print("Match \(match)  Value \(value)")
        
        
        if match == "Acad" {
                   self.academicStr = value
                   self.academicBtn.setTitle(self.academicStr, for: .normal)
                   
               }
               
               if match == "Inst" {
                   self.institutionStr =  value
                   self.institutionBtn.setTitle(self.institutionStr, for: .normal)
                   
               }
        
    }

    
    @IBAction func academicBtnTapped(_ sender: Any) {
       
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
               nextViewController.modalPresentationStyle = .overFullScreen
               nextViewController.matchTable = "Acad"
               nextViewController.delegateTableList = self
               nextViewController.commonArray =  self.academicArray
               self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func institutionBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
                      let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
                      nextViewController.modalPresentationStyle = .overFullScreen
                      nextViewController.matchTable = "Inst"
                      nextViewController.delegateTableList = self
                      nextViewController.commonArray =  self.institutionArray
                      self.present(nextViewController, animated: true, completion: nil)
               
    }
    
  
    
    @IBAction func registerExternalCoorBtn(_ sender: Any) {
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        
        let dict:[AnyHashable : Any] = [
            "academic_degree": self.academicStr,
            "institution_type": self.institutionStr,
            "institution_name": self.institutionNameTF.text!,
            "degree" : self.degreeTF.text!,
            "out_year" : self.outYearTF.text!
        ]
        print(dict)
        Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
            .child(self.worker_Id).child("Personal File").child("Education Data").updateChildValues(dict)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
