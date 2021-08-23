//
//  FunctionRegisterViewController.swift
//  Oliver App IOS
//
//  Created by apple on 06/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class FunctionRegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddressUpdateProtocol {
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var selectiontbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var titleLableArray = Array<Any>()
    var valueLableArray = Array<Any>()
    var frecuenciaArray = Array<Any>()
    var consecuenciaArray = Array<Any>()
    var complejidadArray = Array<Any>()
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViewTable.isHidden = true
        print(self.company_Id)
        tbl.register(UINib(nibName: "OtherFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherFunctionTableViewCell")
        tbl.register(UINib(nibName: "HeaderFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderFunctionTableViewCell")
        selectiontbl.register(UINib(nibName: "CommonListTableViewCell", bundle: nil), forCellReuseIdentifier:  "CommonListTableViewCell")
        self.titleLableArray = ["", "Definir Frecuencia:", "Consecuencia de Error o No Aplicion:", "Complejidad:"]
        self.valueLableArray = ["","Frecuencia...", "Consecuencia de Error o No Aplicion...", "Complejidad..."]
        
        self.frecuenciaArray = ["Todos los días", "Al menos una vez por semana", "Al menos una vez cada quince días", "Al menos una vez al mes", "Otros (Bimestral, Trimestral, Semestral, Anual)"]
        
        self.consecuenciaArray = ["Consecuencias muy graves: pueden afectar a toda la organización en múltiples aspectos. ", "Consecuencias graves: pueden afectar resultados, procesos o áreas funcionales de la organización.", "Consecuencias considerables: repercuten negativamente en los resultados o trabajos de otros. ", "Consecuencias menores: cierta incidencia en resultados o actividades que pertenecen al mismo puesto. ", "Consecuencias mínimas: poca o ninguna incidencia en resultados o actividades. "]
        
        self.complejidadArray = ["Máxima complejidad: la actividad demanda el mayor grado de esfuerzo, conocimientos, habilidades. ", "Alta complejidad: la actividad demanda un considerable nivel de esfuerzo, conocimientos, habilidades ", "Complejidad moderada: la actividad requiere un grado medio de esfuerzo, conocimientos, habilidades. ", "Baja complejidad: la actividad requiere un bajo nivel de esfuerzo, conocimientos, habilidades. ", "Mínima complejidad: la actividad requiere un minimo nivel de esfuerzo, conocimientos o habilidades "]

    }
    
    //MARK:- Update Esfecia Function delegate
    func didUpdateUserAddress(cell:HeaderFunctionTableViewCell) {
        if let cellIndex = self.tbl.indexPath(for: cell) {
            switch cellIndex.row {
            case 0:
                self.descriptionStr = cell.textField.text!
            default:
                print("Not Valid Index")
            }
        }
    }
    
    @IBAction func buttonClose(_ sender: Any) {
           self.subViewTable.isHidden = true
       }
    
    //MARK:- UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tbl {
            return self.valueLableArray.count
        } else {
        return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tbl {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderFunctionTableViewCell", for: indexPath) as! HeaderFunctionTableViewCell
            cell.titleLbl.text = "Especificar Funcion:"
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
            
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherFunctionTableViewCell", for: indexPath) as! OtherFunctionTableViewCell
            cell.titleLbl.text = self.titleLableArray[indexPath.row] as? String
            cell.valueLbl.text = self.valueLableArray[indexPath.row] as? String
            cell.selectionStyle = .none
            return cell
        }
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonListTableViewCell", for: indexPath) as! CommonListTableViewCell
            
            cell.selectionStyle = .none
            cell.subViewSearch.layer.cornerRadius = 5
            cell.subViewSearch.clipsToBounds = true
            
            if self.matchTable == "free" {
                cell.lblText.text =  self.frecuenciaArray[indexPath.row] as? String
            }
            
            if self.matchTable == "cons" {
                cell.lblText.text =  self.consecuenciaArray[indexPath.row] as? String
            }
            
            if self.matchTable == "comp" {
                cell.lblText.text =  self.complejidadArray[indexPath.row] as? String
            }
            return cell
        }
    }
    
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == self.tbl {
            if indexPath.row == 0 {
                return 85
            } else {
                return 110
            }
        } else {
            return 50
        }
    }*/
 
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if tableView == self.tbl {
        if indexPath.row == 1 {
            self.subViewTable.isHidden = false
            self.matchTable = "free"
            self.selectiontbl.reloadData()
        }
        if indexPath.row == 2 {
            self.subViewTable.isHidden = false
            self.matchTable = "cons"
            self.selectiontbl.reloadData()
        }
        
        if indexPath.row == 3 {
            self.subViewTable.isHidden = false

            self.matchTable = "comp"
            self.selectiontbl.reloadData()
        }
        
    } else {
               if self.matchTable == "free" {
                self.frecuencyId = indexPath.row + 1
                if indexPath.row == 0 {
                                       self.frecuencyId = 5
                                   }
                                   if indexPath.row == 1 {
                                       self.frecuencyId = 4
                                   }
                                   if indexPath.row == 2 {
                                       self.frecuencyId = 3
                                   }
                                   if indexPath.row == 3 {
                                       self.frecuencyId = 2
                                   }
                                   if indexPath.row == 4 {
                                       self.frecuencyId = 1
                                   }
                
                print(self.frecuencyId)

                self.frecuencyStr =  self.frecuenciaArray[indexPath.row] as! String
                self.valueLableArray = ["", self.frecuencyStr, self.consecuenceStr, self.complejidStr]
                self.tbl.reloadData()
                self.subViewTable.isHidden = true
                   }
                   
                   if self.matchTable == "cons" {
                    if indexPath.row == 0 {
                        self.consecuenceId = 5
                    }
                    if indexPath.row == 1 {
                        self.consecuenceId = 4
                    }
                    if indexPath.row == 2 {
                        self.consecuenceId = 3
                    }
                    if indexPath.row == 3 {
                        self.consecuenceId = 2
                    }
                    if indexPath.row == 4 {
                        self.consecuenceId = 1
                    }
                    
                    print(self.consecuenceId)
                    self.consecuenceStr = self.consecuenciaArray[indexPath.row] as! String
                self.valueLableArray = ["", self.frecuencyStr, self.consecuenceStr, self.complejidStr]
                    self.tbl.reloadData()
                    self.subViewTable.isHidden = true

                   }
                   
                   if self.matchTable == "comp" {
                    if indexPath.row == 0 {
                        self.complejidId = 5
                    }
                    if indexPath.row == 1 {
                        self.complejidId = 4
                    }
                    if indexPath.row == 2 {
                        self.complejidId = 3
                    }
                    if indexPath.row == 3 {
                        self.complejidId = 2
                    }
                    if indexPath.row == 4 {
                        self.complejidId = 1
                    }
                    
                    print(self.complejidId)
                    self.complejidStr = self.complejidadArray[indexPath.row] as! String
                    self.valueLableArray = ["", self.frecuencyStr, self.consecuenceStr, self.complejidStr]
                    self.tbl.reloadData()
                    self.subViewTable.isHidden = true
                  
                   }
         }
}
    
    @IBAction func registerFuntionBtn(_ sender: Any) {
        let timestamp = NSDate().timeIntervalSince1970
        let timeStampString = String(format: "%.0f",timestamp)
        let finalScore = (self.consecuenceId * self.complejidId) + self.frecuencyId
        let dict:[AnyHashable : Any] = [
            "function_complex": self.complejidStr,
            "function_consequence": self.consecuenceStr,
            "function_description": self.descriptionStr,
            "function_frequency": self.frecuencyStr,
            "function_score": String(finalScore),
        ]
        print(dict)
        Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
            .child(self.worker_Id).child("Functions").child(timeStampString).updateChildValues(dict)
        self.dismiss(animated: true, completion: nil)
        
          }

}
