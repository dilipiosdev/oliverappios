//
//  NormatividadTributariaViewController.swift
//  Oliver App IOS
//
//  Created by apple on 18/02/21.
//

import UIKit
import Firebase
import JGProgressHUD

class ResultadosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tbl: UITableView!
    var titleArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    var totalCount: Int = 0
    var tributariaCount: Float = 0
    var laboralCount: Float = 0
    var sanitariaCount: Float = 0
    var ambientalCount: Float = 0
    var resposibilidadCount: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        print("company id \(companyId)")
        
        self.titleArray = ["","Normatividad Tributaria", "Normatividad Laboral", "Normatividad Sanitaria", "Normatividad Ambiental", "Respons. Civil y Penal"]
        
        tbl.register(UINib(nibName: "ProgressViewTableViewCell", bundle: nil), forCellReuseIdentifier: "ProgressViewTableViewCell")
        tbl.register(UINib(nibName: "ResultadosTopTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultadosTopTableViewCell")
        self.getTributariaList()
        self.getLaboralList()
        self.getAmbientalList()
        self.getSanitariaList()
        self.getResponsibilidadList()
        
    }
    
    //MARK:-TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultadosTopTableViewCell", for: indexPath) as! ResultadosTopTableViewCell
            cell.titleLbl.text = "Resultados de Normatividad"
            cell.descriptionLbl.text = "Descubre que tantas normatividad y responsabilidades formales cumples en tu empresa"
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressViewTableViewCell", for: indexPath) as! ProgressViewTableViewCell
           // cell.progressView.transform = cell.progressView.transform.scaledBy(x: 1, y: 1)
            cell.progressView.layer.cornerRadius = 10
            cell.progressView.clipsToBounds = true
            cell.progressView.layer.sublayers![1].cornerRadius = 10
            cell.progressView.subviews[1].clipsToBounds = true
            
            UIView.animate(withDuration: 2.0) {
                cell.progressView.setProgress(self.tributariaCount / 100, animated: false)
            }
            cell.titleLbl.text  = (self.titleArray[indexPath.row] as! String)
            cell.progressLbl.text = String(format: "%.2f%@",  self.tributariaCount,"%")
            return cell
        }  else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressViewTableViewCell", for: indexPath) as! ProgressViewTableViewCell
          //  cell.progressView.transform = cell.progressView.transform.scaledBy(x: 1, y: 1)
            cell.progressView.layer.cornerRadius = 10
            cell.progressView.clipsToBounds = true
            cell.progressView.layer.sublayers![1].cornerRadius = 10
            cell.progressView.subviews[1].clipsToBounds = true
            UIView.animate(withDuration: 2.0) {
                cell.progressView.setProgress(self.laboralCount / 100, animated: false)
            }
            
            cell.titleLbl.text  = (self.titleArray[indexPath.row] as! String)
            cell.progressLbl.text = String(format: "%.2f%@", self.laboralCount,"%")
            return cell
            
        }  else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressViewTableViewCell", for: indexPath) as! ProgressViewTableViewCell
           // cell.progressView.transform = cell.progressView.transform.scaledBy(x: 1, y: 1)
            cell.progressView.layer.cornerRadius = 10
            cell.progressView.clipsToBounds = true
            cell.progressView.layer.sublayers![1].cornerRadius = 10
            cell.progressView.subviews[1].clipsToBounds = true
            UIView.animate(withDuration: 2.0) {
                cell.progressView.setProgress(self.sanitariaCount / 100, animated: false)
            }
            cell.titleLbl.text  = (self.titleArray[indexPath.row] as! String)
            cell.progressLbl.text = String(format: "%.2f%@", self.sanitariaCount,"%")
            return cell
            
        } else if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressViewTableViewCell", for: indexPath) as! ProgressViewTableViewCell
           // cell.progressView.transform = cell.progressView.transform.scaledBy(x: 1, y: 4)
            cell.progressView.layer.cornerRadius = 10
            cell.progressView.clipsToBounds = true
            cell.progressView.layer.sublayers![1].cornerRadius = 10
            cell.progressView.subviews[1].clipsToBounds = true
            
            UIView.animate(withDuration: 2.0) {
                cell.progressView.setProgress(self.ambientalCount / 100, animated: false)
            }
            cell.titleLbl.text  = (self.titleArray[indexPath.row] as! String)
            cell.progressLbl.text = String(format: "%.2f%@", self.ambientalCount,"%")
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressViewTableViewCell", for: indexPath) as! ProgressViewTableViewCell
           // cell.progressView.transform = cell.progressView.transform.scaledBy(x: 1, y: 1)
            cell.progressView.layer.cornerRadius = 10
            cell.progressView.clipsToBounds = true
            cell.progressView.layer.sublayers![1].cornerRadius = 10
            cell.progressView.subviews[1].clipsToBounds = true
            UIView.animate(withDuration: 2.0) {
                cell.progressView.setProgress(self.resposibilidadCount / 100, animated: false)
            }
            cell.titleLbl.text  = (self.titleArray[indexPath.row] as! String)
            cell.progressLbl.text = String(format:"%.2f%@", self.resposibilidadCount,"%")
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 100
        } else {
            return 65
        }
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getTributariaList() -> Void {
        
        var santotalCount = 0
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Taxes")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.purchasedOrderArray = array
                print("Arrayyy is \(self.purchasedOrderArray)")
                for count in self.purchasedOrderArray {
                    let obj = count as! DataSnapshot
                    if let value1 = obj.value {
                        print(value1)
                        if value1 as! Int == 0 {
                        } else {
                            santotalCount = santotalCount + 1
                        }
                    }
                }
                self.tributariaCount  = Float(santotalCount * 100 / 6)
                print("Total self.tributariaCount is \(self.tributariaCount)")               }
        }
    }
    
    
    func getLaboralList() -> Void {
        var santotalCount = 0
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Labour")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.purchasedOrderArray = array
                print("Arrayyy is \(self.purchasedOrderArray)")
                for count in self.purchasedOrderArray {
                    let obj = count as! DataSnapshot
                    if let value1 = obj.value {
                        print(value1)
                        if value1 as! Int == 0 {
                        } else {
                            santotalCount = santotalCount + 1
                        }
                    }
                }
                self.laboralCount  = Float(santotalCount * 100 / 9)
                print("Total finalValue is \(self.laboralCount)")               }
        }
    }
    
    func getSanitariaList() -> Void {
        var santotalCount = 0
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Sanitary")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.purchasedOrderArray = array
                print("Arrayyy is \(self.purchasedOrderArray)")
                for count in self.purchasedOrderArray {
                    let obj = count as! DataSnapshot
                    if let value1 = obj.value {
                        print(value1)
                        if value1 as! Int == 0 {
                        } else {
                            santotalCount = santotalCount + 1
                        }
                    }
                }
                self.sanitariaCount = Float(santotalCount * 100 / 6)
                print("Total self.sanitariaCount is \(self.sanitariaCount)")
                
            }
        }
    }
    
    func getAmbientalList() -> Void {
        var santotalCount = 0
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Environmental")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.purchasedOrderArray = array
                print("Arrayyy is \(self.purchasedOrderArray)")
                for count in self.purchasedOrderArray {
                    let obj = count as! DataSnapshot
                    if let value1 = obj.value {
                        print(value1)
                        if value1 as! Int == 0 {
                        } else {
                            santotalCount = santotalCount + 1
                        }
                    }
                }
                self.ambientalCount  = Float(santotalCount * 100 / 6)
                print("Total  self.ambientalCount is \( self.ambientalCount)")
                
            }
        }
    }
    
    func getResponsibilidadList() -> Void {
        var santotalCount = 0
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Normativity").child("Civil")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.purchasedOrderArray = array
                print("Arrayyy is \(self.purchasedOrderArray)")
                for count in self.purchasedOrderArray {
                    let obj = count as! DataSnapshot
                    if let value1 = obj.value {
                        print(value1)
                        if value1 as! Int == 0 {
                        } else {
                            santotalCount = santotalCount + 1
                        }
                    }
                }
                self.resposibilidadCount  = Float(santotalCount * 100 / 8)
                print("Total self.resposibilidadCount is \(self.resposibilidadCount)")
            }
            self.tbl.delegate = self
            self.tbl.dataSource = self
            self.tbl.reloadData()
        }
    }
    
}





