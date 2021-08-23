//
//  NormatividadTributariaViewController.swift
//  Oliver App IOS
//
//  Created by apple on 18/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class ResponsabilidadViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, YesNoButtonSetProtocol {
    
    @IBOutlet weak var tbl: UITableView!
    var titleArray = Array<Any>()
    var especificationArray = Array<Any>()
    var decrtoArray = Array<Any>()
    var topLblArray = Array<Any>()
    var purchasedOrderArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var totalCount: Float = 0
    var dict:[AnyHashable : Any] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        
        
        self.titleArray = ["","Seguridad y Salud en el Trabajo", "Protección y defensa del consumidor", "Principio de identidad", "Ley General de Sociedades", "Ley Laboral para Régimen Privado", "Responsabilidad administrativa de las personas jurídicas", "Tercerización de Servicios", "Prevención de Riesgos laborales "]
        
        self.especificationArray =  ["","Mecanismos de prevención y control de COVID-19 en el lugar de trabajo, aprobado por el Comité de Seguridad y Salud del comercio/negocio/empresa que se ha debido de crear de forma obligatoria con anterioridad.", "El presente Código establece las normas de protección y defensa de los derechos de los consumidores.", "Establecen las obligaciones de una persona/negocio/comercio /empresa en dar el bien con todas las cualidades que el comprador ha solicitado, sin dar un producto/servicio mayor o menor sino igual al que se ha solicitado del cual ambas partes han estado de acuerdo.", "Instrumento legal que proporciona las pautas jurídicas o legales para el funcionamiento regular de aquellas empresas que se constituyen como sociedad, con la finalidad de evitar infracciones o sanciones con relación a su funcionamiento", "La presente Ley regula las prestaciones personales, subordinadas y remuneradas de servicios, nacidas de un contrato verbal o escrito, cualquiera fuera la denominación o modalidad de este, y las relaciones colectivas de trabajo. ", "La implementación voluntaria de un modelo de prevención tiene como finalidad la prevención, detección y mitigación de la comisión de delitos, así como promover la integridad y transparencia en la gestión de las personas jurídicas.","Ley que regula los servicios de tercerización, el cuál regula los casos en que procede la tercerización, los requisitos, derechos y obligaciones, así como las sanciones aplicables a las empresas que desnaturalizan el uso de este método de vinculación empresarial.", "El art. 14 de la Ley de Prevención de Riesgos Laborales (LPRL) impone al empresario una serie de obligaciones a fin de garantizar la seguridad y la salud en el trabajo, reconociendo al trabajador el derecho a una protección eficaz en esta materia." ]
        
        self.decrtoArray =  ["","RM 377-2020-MINSA", "LEY Nº 29571", "Art. 1132 del Código Civil", "Art. 9 y 10 de la Ley N° 26887", "DS 002-97 TR / DS 003-97-TR / DS 001-96-TR / DL 1378 / DL 728", "Ley Nº 30424", "Ley Nº 29245", " Ley Nº 29783" ]
        
        tbl.register(UINib(nibName: "MidTableViewCell", bundle: nil), forCellReuseIdentifier: "MidTableViewCell")
        tbl.register(UINib(nibName: "TopTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTableViewCell")
        tbl.register(UINib(nibName: "BottomTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomTableViewCell")
        self.getProductList()
        
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell", for: indexPath) as! TopTableViewCell
            cell.titleLbl.text = "Normatividad Civil y Penal"
            cell.descriptionLbl.text = "¿Qué debes de tener en cuenta para cumplir tus oblogaciones civiles y penales o las de tu comercio/negocio/empresa?"
            return cell
            
        } else if indexPath.row == self.titleArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
            let finalValue  = Float (self.totalCount * 100 / 8)
            cell.totalComutationLbl.text = String(format: "TOTAL COMPLIMIENTO: %.2f%@", finalValue,"%")
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MidTableViewCell", for: indexPath) as! MidTableViewCell
            cell.titleLbl.text  = (self.titleArray[indexPath.row] as! String)
            cell.specificationLbl.text  = (self.especificationArray[indexPath.row] as! String)
            cell.decretoLbl.text  = (self.decrtoArray[indexPath.row] as! String)
            cell.selectionStyle = .none
            cell.delegate = self
            cell.indexPath = indexPath
             if self.purchasedOrderArray.isEmpty == false {
            if indexPath.row == 1 {
                let obj = self.purchasedOrderArray[0] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
            }
            
            if indexPath.row == 2 {
                let obj = self.purchasedOrderArray[1] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
                
            }
            
            if indexPath.row == 3 {
                let obj = self.purchasedOrderArray[2] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
            }
            
            if indexPath.row == 4 {
                let obj = self.purchasedOrderArray[3] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
                
            }
            
            if indexPath.row == 5 {
                let obj = self.purchasedOrderArray[4] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
            }
            
            if indexPath.row == 6 {
                let obj = self.purchasedOrderArray[5] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
            }
            
            if indexPath.row == 7 {
                let obj = self.purchasedOrderArray[6] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
            }
            
            if indexPath.row == 8 {
                let obj = self.purchasedOrderArray[7] as! DataSnapshot
                if let value1 = obj.value {
                    print(value1)
                    if value1 as! Int == 0 {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
                    } else {
                        cell.siBtn.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
                    }
                }
            }
            
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 130
        } else if indexPath.row == self.titleArray.count {
            return 60
        } else {
            return 325
            
        }
    }
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Civil")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.purchasedOrderArray = array
                print("Arrayyy is \(self.purchasedOrderArray)")
                self.tbl.delegate = self
                self.tbl.dataSource = self
                self.tbl.reloadData()
                self.calculateTotalCount()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    func calculateTotalCount() {
        self.totalCount = 0
        for count in self.purchasedOrderArray {
            let obj = count as! DataSnapshot
            if let value1 = obj.value {
                print(value1)
                if value1 as! Int == 0 {
                } else {
                    self.totalCount = self.totalCount + 1
                }
            }
        }
        print("Total Count is \(self.totalCount)")
    }
    
    //MARK-: YES No Button delegate Methods
       func yesNoButtonTapped(yesnoStr: Int, indexPath: IndexPath) {
         
           if indexPath.row == 1 {
               self.dict = [
                   "norm_1": yesnoStr
               ]
           }
           if indexPath.row == 2 {
               self.dict = [
                   "norm_2": yesnoStr
               ]
           }
           if indexPath.row == 3 {
               self.dict = [
                   "norm_3": yesnoStr
               ]
           }
           if indexPath.row == 4 {
               self.dict = [
                   "norm_4": yesnoStr
               ]
           }
           
           if indexPath.row == 5 {
               self.dict = [
                   "norm_5": yesnoStr
               ]
           }
           
           if indexPath.row == 6 {
               self.dict = [
                   "norm_6": yesnoStr
               ]
           }
        
        if indexPath.row == 7 {
                      self.dict = [
                          "norm_7": yesnoStr
                      ]
                  }
                  
                  if indexPath.row == 8 {
                      self.dict = [
                          "norm_8": yesnoStr
                      ]
                  }
           
           Database.database().reference().child("My Companies").child(self.companyId).child("Normativity")
               .child("Civil").updateChildValues(dict)
           self.getProductList()
       }
    
    
}

