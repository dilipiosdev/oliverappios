//
//  FunctionRegisterViewController.swift
//  Oliver App IOS
//
//  Created by apple on 06/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class IntenalViewController: UIViewController, TableListDelegate {
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var selectiontbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var denominationArray = Array<Any>()
    var areaArray = Array<Any>()

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
    
    //Mark:- Interna View ...
    @IBOutlet var internaViewBtn: UIButton!
     @IBOutlet var externaViewBtn: UIButton!
    @IBOutlet var denominationBtn: UIButton!
     @IBOutlet var areaBtn: UIButton!
    @IBOutlet var internaView: UIView!

    @IBOutlet var coordImmediateBossTF: UITextField!
    var coordAreaStr = String()
    var coordDenominationStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.company_Id)
        print(self.worker_Id)
        self.internaViewBtn.backgroundColor = UIColor.darkGray

       
        
        self.denominationArray = ["Practicante / Becario", "Operario/a", "Asistente administrativo/a", "Secretaria/o", "Recepcionista", "Comercial o Vendedor", "Analista", "Especialista", "Jefe de Area", "Gerente", "Directivo", "Presidente", "Socio"]
        
        self.areaArray = ["Junta Directiva", "Presidencia", "Direccion General", "Gerencia General", "Financiera y Contabilidad", "Administrativa", "Comercial y Ventas", "Recursos Humanos", "Produccion y Logistca", "Marketing", "Sistemas y Tecnologia", "Archivos centrales", "Compras", "Secretaria General"]

    }

    func callTableViewList(match: String, value: String) {
        print("Match \(match)  Value \(value)")
        
        if  match == "Area" {
               self.coordAreaStr =  value
               self.internaView.isHidden = false
               self.areaBtn.setTitle(self.coordAreaStr, for: .normal)
           }
         if  match == "Deno" {
        
               self.coordDenominationStr =  value
               self.internaView.isHidden = false
               self.denominationBtn.setTitle(self.coordDenominationStr, for: .normal)
           }
        
      
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
    
    @IBAction func internaViewBtnTapped(_ sender: Any) {
           self.internaViewBtn.backgroundColor = UIColor.darkGray
           self.externaViewBtn.backgroundColor = UIColor.white

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
    
    
    @IBAction func registerInternalCoorBtn(_ sender: Any) {
        let timestamp = NSDate().timeIntervalSince1970
        let requestTimeStamp = String(format: "%.2f",timestamp)
        let timeStampString = String(format: "%.0f",timestamp)
       
        let dict:[AnyHashable : Any] = [
            "coordination_denomination": self.coordDenominationStr,
            "coordination_area": self.coordAreaStr,
            "coordination_immediate_boss_name": self.coordImmediateBossTF.text!,
            "timestamps": requestTimeStamp
        ]
        
        print(dict)
        
        Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
            .child(self.worker_Id).child("Internal Coordination").child(timeStampString).updateChildValues(dict)

        self.dismiss(animated: true, completion: nil)

}
}
    
