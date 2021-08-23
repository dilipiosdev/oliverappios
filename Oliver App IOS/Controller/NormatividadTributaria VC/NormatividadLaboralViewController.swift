//
//  NormatividadTributariaViewController.swift
//  Oliver App IOS
//
//  Created by apple on 18/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class NormatividadLaboralViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, YesNoButtonSetProtocol  {
    
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
        
        self.titleArray = ["","Seguridad y Salud", "Inspecciones Laborales", "Cierre de Locales por Accidentes", "Seguro de Vida Ley", "Atentado contra las condiciones de Seguridad en el Trabajo", "Constancia de cese del Trabajador", "Formatos de Essalud","Casilla electrónica de Sunafil", "Días no Laborables compensables"]
        
        self.especificationArray = ["","Los empleadores deben garantizar la adecuada protección de los trabajadores. En el caso de accidentes de trabajo, seguido de muerte del trabajador, las actuaciones de investigación a empresarios deben culminar en un plazo máximo de diez días hábiles, prorrogables -por única vez- por un plazo igual.", "La Superintendencia Nacional de Fiscalización Laboral (Sunafil) podrá programar más de una orden de trabajo, cuando se trate de inspecciones en materia de seguridad y salud en el trabajo, derechos fundamentales, registro de trabajadores, así como en los casos de denuncias por incumplimiento de obligaciones socio laborales", "Los inspectores de trabajo están facultados para disponer la paralización o prohibición inmediata de trabajos, y ordenar el cierre temporal del área de una unidad económica en caso se produzca un accidente mortal en el centro de trabajo, hasta por un plazo de 30 días calendario.", "Los empleadores estarán obligados a contratar una póliza de seguro de vida a sus empleados y obreros a partir del inicio de la relación laboral. Su aplicación será progresiva (D.U. 044-2019 del 30 de diciembre de 2019). Esta norma está vigente desde el 11 de febrero de 2020, según el reglamento aprobado por el Decreto Supremo 009-2020-TR publicado el 10 de febrero de este año en el diario oficial El Peruano.", "Se modifica el Art. 168-A del Código Penal, sancionando hasta con cuatro años de prisión, a quien deliberadamente (delito doloso), infringiendo las normas de la Seguridad y Salud en el Trabajo (SST) y estando legalmente obligado, aun cuando no haya sido previamente notificado por la autoridad, ponga en peligro inminente la vida, salud o integridad física del trabajador. La pena se extenderá hasta ocho años en caso de muerte del trabajador. Del nuevo texto del artículo 168-A del Código Penal se elimina el párrafo que disponía: “Se excluye de responsabilidad penal cuando la muerte o lesiones graves son producto de la inobservancia de las normas SST por parte del trabajador” (D.U. 044-2019 del 30 diciembre de 2019).","Ante la negativa o demora del empleador en otorgar la constancia de cese, la Autoridad Administrativa de Trabajo tendrá 15 días hábiles para expedirle la referida constancia, que sirve para el retiro de la CTS depositada en el banco", "Se modificó el reglamento de inscripción, baja y modificación de datos del titular y de los derechohabientes del asegurado. Para tal efecto, se aprobó el formulario 1010 “Formulario Único de Seguros” y el Formato de Declaración Jurada para la inscripción y baja de los asegurados al Es Salud", "La Sunafil asignará a los usuarios una casilla electrónica, la que será el domicilio digital obligatorio para la notificación de los actos administrativos y/o actuaciones en las fiscalizaciones laborales ","Cabe resaltar que aún el Gobierno peruano no ha definido si habrá días no laborables compensables este año 2021"]
        
        self.decrtoArray = ["","D.S. 020-2019-TR del 24 de diciembre de 2019", " D.S. 020-2019-TR publicado el 24 de diciembre de 2019", "D.S. 044-2019-TR del 30 de diciembre de 2019", "D.U. 044-2019 del 30 de diciembre de 2019 y Decreto Supremo 009-2020-TR", "Art. 168-A del Código Penal y D.U. 044-2019 del 30 diciembre de 2019", "D.S.05-2019-TR del 11 de agosto de 2019", "D-S- 012-2019-TR del 11 de octubre de 2019","D.S. 03-2020-TR del 14 de enero de 2020", ""]
        
        
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
            cell.titleLbl.text = "Normatividad Laboral"
            cell.descriptionLbl.text = "¿Qué debes de tener en cuenta para cumplir tus obligaciones laborales o las de tu comercio/negocio/empresa?"
            return cell
            
        } else if indexPath.row == self.titleArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
            let finalValue  = Float (self.totalCount * 100 / 9)
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
                        cell.siBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
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
            
            if indexPath.row == 9 {
                let obj = self.purchasedOrderArray[8] as! DataSnapshot
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
        }
        else {
            return 325
            
        }
    }
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Labour")
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
            if indexPath.row == 9 {
                self.dict = [
                    "norm_9": yesnoStr
                ]
            }
             
             Database.database().reference().child("My Companies").child(self.companyId).child("Normativity")
                 .child("Labour").updateChildValues(dict)
             self.getProductList()
         }
    
    
}
