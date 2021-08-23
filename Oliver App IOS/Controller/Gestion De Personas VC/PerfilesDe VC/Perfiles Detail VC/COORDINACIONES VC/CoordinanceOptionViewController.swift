//
//  CoordinanceOptionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class CoordinanceOptionViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var internalTbl: UITableView!
    @IBOutlet weak var externalTbl: UITableView!

    var companyDetailDict = DataSnapshot()
    var company_Id = String()
    var worker_Id = String()
    var internalWorkerListArray = Array<Any>()
    var externalWorkerListArray = Array<Any>()
    @IBOutlet var popUpView: UIView!
    @IBOutlet var internaBtn: UIButton!
    @IBOutlet var externaBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpView.isHidden = true

        internalTbl.register(UINib(nibName: "InternalTableViewCell", bundle: nil), forCellReuseIdentifier: "InternalTableViewCell")
        externalTbl.register(UINib(nibName: "ExternalTableViewCell", bundle: nil), forCellReuseIdentifier: "ExternalTableViewCell")
        self.getInternalWorkerList()
        self.getExternalWorkerList()
    }
    
    @IBAction func registerCoordBtnTapped(_ sender: UIButton) {
        self.popUpView.isHidden = false
        self.internaBtn.backgroundColor = UIColor.white
        self.externaBtn.backgroundColor = UIColor.white

    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.popUpView.isHidden = true
        

    }
    
    
    @IBAction func buttonInterna(_ sender: Any) {
           self.internaBtn.backgroundColor = UIColor.darkGray
           self.externaBtn.backgroundColor = UIColor.white
           self.popUpView.isHidden = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "IntenalViewController") as! IntenalViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.worker_Id = self.worker_Id
        nextViewController.company_Id = self.company_Id
        self.present(nextViewController, animated: true, completion: nil)

             }
       
       @IBAction func buttonExterna(_ sender: Any) {
           self.internaBtn.backgroundColor = UIColor.white
           self.externaBtn.backgroundColor = UIColor.darkGray
           self.popUpView.isHidden = true
               
           let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ExternalViewController") as! ExternalViewController
               nextViewController.companyDetailDict = companyDetailDict
               nextViewController.worker_Id = self.worker_Id
               nextViewController.company_Id = self.company_Id
               self.present(nextViewController, animated: true, completion: nil)
           
             }
    
    
    //MARK:- UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.internalTbl {
            return self.internalWorkerListArray.count
        } else {
            return self.externalWorkerListArray.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.internalTbl {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InternalTableViewCell", for: indexPath) as! InternalTableViewCell
            let obj = self.internalWorkerListArray[indexPath.row] as! DataSnapshot
            
    cell.coordImmediateBossLbl.text = "Jefe Inmediato: \( obj.childSnapshot(forPath: "coordination_immediate_boss_name").value as? String ?? "")"
            
    cell.coordDenominationLbl.text = "Cargo: \( obj.childSnapshot(forPath: "coordination_denomination").value as? String ?? "")"
                       
    cell.coordAreaLbl.text = "Area: \( obj.childSnapshot(forPath: "coordination_area").value as? String ?? "")"
            
            if indexPath.row == 0 {
                 cell.headerLbl.text = "COORDINACIONES INTERNAS"
                
            } else {
                cell.headerLbl.text = ""
            }
    cell.selectionStyle = .none

            return cell
            
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExternalTableViewCell", for: indexPath) as! ExternalTableViewCell
            
            let obj = self.externalWorkerListArray[indexPath.row] as! DataSnapshot

            cell.coordImmediateLbl.text = "Jefe Inmediato: \( obj.childSnapshot(forPath: "coordination_immediate_boss_name").value as? String ?? "")"
                       
               cell.coordDenominationLbl.text = "Cargo: \( obj.childSnapshot(forPath: "coordination_denomination").value as? String ?? "")"
                                  
               cell.coordCompanyLbl.text = "Empresa: \( obj.childSnapshot(forPath: "coordination_company").value as? String ?? "")"
            
            cell.coordEmailLbl.text = "Correo: \( obj.childSnapshot(forPath: "coordination_email").value as? String ?? "")"
            
             cell.coordPhoneNoLbl.text = "Telefono: \( obj.childSnapshot(forPath: "coordination_phone").value as? String ?? "")"
            if indexPath.row == 0 {
                 cell.headerLbl.text = "COORDINACIONES EXTERNAS"
                           
                       } else {
                           cell.headerLbl.text = ""
                       }
               cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
          if tableView == self.internalTbl {
            return 175
        }
        else {
            return 245
        }
    }
    
    //MARK:- Get Worked List
       func getInternalWorkerList() -> Void {
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
             self.company_Id = dict["Compnay_Id"]!
        }
           let hud = JGProgressHUD(style: .light)
           hud.textLabel.text = "Loading"
           hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(self.company_Id)").child("Job Profile/\(self.worker_Id)").child("Internal Coordination")
           userRef.observe(.value) { (snapshot) in
               if let array = snapshot.children.allObjects as? Array<Any>
               {
                   hud.dismiss()
                   self.internalWorkerListArray = array
                   print("internalWorkerListArray is \(self.internalWorkerListArray)")
                   self.internalTbl.delegate = self
                   self.internalTbl.dataSource = self
                   self.internalTbl.reloadData()
               }
               else
               {
                   hud.dismiss()
               }
           }
       }
    
    
    func getExternalWorkerList() -> Void {
     
     if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
         self.worker_Id = dict["Worker_Id"]!
        self.company_Id = dict["Compnay_Id"]!

     }
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
     let userRef = Database.database().reference().child("My Companies/\(self.company_Id)").child("Job Profile/\(self.worker_Id)").child("External Coordination")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.externalWorkerListArray = array
                print("externalWorkerListArray is \(self.externalWorkerListArray)")
                self.externalTbl.delegate = self
                self.externalTbl.dataSource = self
                self.externalTbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }    
    
}
