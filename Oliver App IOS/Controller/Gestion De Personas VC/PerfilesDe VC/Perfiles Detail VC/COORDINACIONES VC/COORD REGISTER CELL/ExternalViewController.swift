//
//  FunctionRegisterViewController.swift
//  Oliver App IOS
//
//  Created by apple on 06/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class ExternalViewController: UIViewController, TableListDelegate {
    func callTableViewList(match: String, value: String) {
        self.coordDenominationStr = value
        self.denominationBtn.setTitle(self.coordDenominationStr, for: .normal)
    
    }
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var selectiontbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var denominationArray = Array<Any>()
    @IBOutlet var subViewTable: UIView!
    @IBOutlet var txtSearch: UITextField!
    var matchTable = String()
    var frecuencyId : Int = 0
    var consecuenceId : Int = 0
    var complejidId : Int = 0
    var frecuencyStr = String()
    var consecuenceStr = String()
    var complejidStr = String()
    var descriptionStr = String()
    var company_Id = String()
    var worker_Id = String()
    
    @IBOutlet var internaBtn: UIButton!
    @IBOutlet var externaBtn: UIButton!
    @IBOutlet var denominationBtn: UIButton!

    
    //Mark:- Externa View ...
    @IBOutlet var internaViewBtn: UIButton!
    @IBOutlet var externaViewBtn: UIButton!
    @IBOutlet var externaView: UIView!
    var coordDenominationStr = String()
    @IBOutlet var coordImmediateBossNameTF: UITextField!
    @IBOutlet var coordCompanyTF: UITextField!
    @IBOutlet var coordEmailTF: UITextField!
    @IBOutlet var coordPhoneTF: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.externaViewBtn.backgroundColor = UIColor.darkGray

        print(self.company_Id)
     
        self.denominationArray = ["Practicante / Becario", "Operario/a", "Asistente administrativo/a", "Secretaria/o", "Recepcionista", "Comercial o Vendedor", "Analista", "Especialista", "Jefe de Area", "Gerente", "Directivo", "Presidente", "Socio"]
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
        
        @IBAction func internaViewBtnTapped(_ sender: Any) {
               self.internaViewBtn.backgroundColor = UIColor.darkGray
               self.externaViewBtn.backgroundColor = UIColor.white
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IntenalViewController") as! IntenalViewController
                                    nextViewController.companyDetailDict = companyDetailDict
                                    nextViewController.worker_Id = self.worker_Id
                                    nextViewController.company_Id = self.company_Id
                           self.present(nextViewController, animated: true, completion: nil)

                 }
           
           @IBAction func externaViewBtnTapped(_ sender: Any) {
               self.internaViewBtn.backgroundColor = UIColor.white
               self.externaViewBtn.backgroundColor = UIColor.darkGray
            let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ExternalViewController") as! ExternalViewController
                         nextViewController.companyDetailDict = companyDetailDict
                         nextViewController.worker_Id = self.worker_Id
                         nextViewController.company_Id = self.company_Id
                self.present(nextViewController, animated: true, completion: nil)
               
                 }
        
       
        
        @IBAction func registerExternalCoorBtn(_ sender: Any) {
            let timestamp = NSDate().timeIntervalSince1970
            let timeStampString = String(format: "%.0f",timestamp)
           let requestTimeStamp = String(format: "%.2f",timestamp)

            let dict:[AnyHashable : Any] = [
                "coordination_denomination": self.coordDenominationStr,
                "coordination_company": self.coordCompanyTF.text!,
                "coordination_immediate_boss_name": coordDenominationStr,
                "coordination_email" : self.coordEmailTF.text!,
                "coordination_phone" : self.coordPhoneTF.text!,
                "timestamps": requestTimeStamp
                
            ]
            print(dict)
            Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
                .child(self.worker_Id).child("External Coordination").child(timeStampString).updateChildValues(dict)
            self.dismiss(animated: true, completion: nil)
    }

}
