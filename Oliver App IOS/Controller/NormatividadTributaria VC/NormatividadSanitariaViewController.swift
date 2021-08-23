//
//  NormatividadTributariaViewController.swift
//  Oliver App IOS
//
//  Created by apple on 18/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class NormatividadSanitariaViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, YesNoButtonSetProtocol {
    
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

        self.titleArray = ["","Salud de los Trabajadores", "Protección al Consumidor", "Mercados de Abastos", "Fabricación, Elaboración y Exopendio de productos de Panificación, Galletería y Pastelería", "Alimentos y Bebidas", "Akimentos y Bebidas", "Preparación y Venta de Alimentos en la Vía Pública"]
                         
        self.especificationArray = ["","Lineamientos para la Vigilancia, Prevención y Control de la salud de los trabajadores con riesgo de exposición a COVID-19", "Normas de protección al consumidor, ya sea que se encuentre directa ó indirectamente, expuesto o comprendido por una relación de consumo o en una etapa preliminar a ésta.", "El presente reglamento establece las condiciones y re- quisitos sanitarios a los que debe sujetarse el funciona- miento de los mercados de abasto sean públicos o priva- dos, en las diferentes etapas de la cadena alimentaria, con la finalidad de asegurar la calidad sanitaria e inocuidad de los alimentos y bebidas. ", "Norma sanitaria tiene como propósito proteger la salud de los consumidores, disponiendo los requisitos sanitarios que deben cumplir los productos de panificación, galletería y pastelería y los establecimientos que los fabrican, elaboran y expenden. ", "Funcionamiento de restaurantes y servicios afines, vigilancia sanitaria de los alimentos y bebidas que se comercializan en los restaurantes y servicios afines, definida en infarestructuras e instalaciones, preparación de alimentos, manipulación de alimentos. Ver ficha sanitaria que se adjunta (que debe de estar en formato descargable)", "Protocolo Sanitario Simplificado, con carácter temporal, que será aplicada hasta la culminación de la Emergencia Sanitaria declarada con Decreto Supremo N 008-2020-SA y su modificatoria, para los Procedimientos de Certificación de Evaluación Previa de alimentos.", "Contiene pautas higiénicos sanitarias que deben cumplirse en la preparación y  venta de alimentos en la via pública"]
        
        self.decrtoArray = ["","RM 448-2020-MINSA", "Ley 29571", "RM 282-2003-SA/DM", "RM 1020-2010/MINSA", "DS 007-98-SA y RM 363-2005/Minsa", "DS 008-2020-SA", "RM 0014-92-SA/DM"]
        
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
                cell.titleLbl.text = "Normatividad Sanitaria"
                cell.descriptionLbl.text = "¿Qué debes de tener en cuenta para cumplir tus obligaciones sanitarias o las de tu comercio/negocio/empresa?"
                return cell
                
            } else if indexPath.row == self.titleArray.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
                 let finalValue  = Float (self.totalCount * 100 / 6)
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
            let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Sanitary")
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
           
           Database.database().reference().child("My Companies").child(self.companyId).child("Normativity")
               .child("Sanitary").updateChildValues(dict)
           self.getProductList()
       }
       
    
    }

