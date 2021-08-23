//
//  NormatividadTributariaViewController.swift
//  Oliver App IOS
//
//  Created by apple on 18/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class NormatividadTributariaViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, YesNoButtonSetProtocol {
    
    
    @IBOutlet weak var tbl: UITableView!
    var titleArray = Array<Any>()
    var especificationArray = Array<Any>()
    var decrtoArray = Array<Any>()
    var topLblArray = Array<Any>()
    var purchasedOrderArray = Array<Any>()
    var totalCount: Float = 0
    
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var worker_Id = String()
    var dict:[AnyHashable : Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        
        self.titleArray = ["","Próroga de exoneraciones tributarias", "Cuarta categoría", "Impuesto predial 2021", "Régimen de gradualidad","Financiamiento de deudas Essalud", "Incentivos tributarios por innovación y tecnología"]
        
        self.especificationArray = ["","Hasta el 31 de diciembre de 2021, se han prorrogado las exoneraciones del Impuesto a la Renta (IR) a las asociaciones y fundaciones, así como las exoneraciones del IGV aplicable a los bienes y servicios comprendidos en los apéndices I y II de la Ley del IGV","Los trabajadores independientes cuyos honorarios a percibir en el año 2021 no superen los S/38,500.00 no pagarán el IR. Estos contribuyentes tendrán derecho a solicitar a Sunat la suspensión de retenciones (8%) de 4ta categoría","Establecen monto mínimo del Impuesto Predial, fechas de vencimiento para el pago del Impuesto Predial y Arbitrios Municipales correspondientes al Ejercicio Fiscal 2021, régimen de incentivos por Pronto Pago y fecha de vencimiento para presentación de hoja de actualización de datos con carácter de Declaración Jurada","La Sunat modificó el régimen de gradualidad de sanciones vinculadas a las infracciones por no registrar ingresos o rentas en libros electrónicos,  se incorpora al régimen de gradualidad a la infracción tipificada en el numeral 10 del artículo 175° del Código Tributario","Las deudas de las micro y pequeñas empresas a Es Salud, generadas hasta el año 2015, podrán ser fraccionadas hasta en diez años, excluyendo las multas y los intereses moratorios ","El gobierno prorrogó hasta el 31 de diciembre de 2022 los incentivos tributarios a los proyectos de investigación científica, desarrollo e innovación tecnológica a cargo de las empresas y de los centros de investigación privados"]
        
        self.decrtoArray = ["","Ley 31105 del 31.12.2020"," Resolución de Superintendencia Nº 225-2020/SUNAT","ORDENANZA N° 310-2020-MDSMM","Res. 226-2019-SUNAT del 7 de noviembre de 2019","D.U. 037-2019 del 26 de diciembre de 2019","D.U. 010-2019 del 31 de noviembre de 2019"]
        
        tbl.register(UINib(nibName: "MidTableViewCell", bundle: nil), forCellReuseIdentifier: "MidTableViewCell")
        tbl.register(UINib(nibName: "TopTableViewCell", bundle: nil), forCellReuseIdentifier: "TopTableViewCell")
        tbl.register(UINib(nibName: "BottomTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomTableViewCell")
        self.getProductList()
        
    }

    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.titleArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell", for: indexPath) as! TopTableViewCell
            cell.titleLbl.text = "Normatividad Tributaria"
            cell.descriptionLbl.text = "¿Qué debes de tener en cuenta para cumplir tus obligaciones tributarias o las de tu comercio/negocio/empresa?"
            return cell
            
        } else if indexPath.row == self.titleArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
            let finalValue  = Float (self.totalCount * 100 / 6)
            cell.totalComutationLbl.text = String(format: "TOTAL COMPLIMIENTO: %.2f%@", finalValue,"%")
            
           // "TOTAL COMPLIMIENTO:  \(finalValue)%"
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
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Taxes")
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
            .child("Taxes").updateChildValues(dict)
        self.getProductList()
    }
    
}

