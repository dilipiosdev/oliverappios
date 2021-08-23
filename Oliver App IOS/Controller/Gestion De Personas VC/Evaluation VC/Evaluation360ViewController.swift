//
//  PerfilesViewController.swift
//  Oliver App IOS
//
//  Created by apple on 02/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class Evaluation360ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingButtonProtocol {
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var workerListArray = Array<Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "PerfilesTopTableViewCell", bundle: nil), forCellReuseIdentifier: "PerfilesTopTableViewCell")
        tbl.register(UINib(nibName: "WorkerTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkerTableViewCell")
        companyId = companyDetailDict.key
        self.getWorkerList()
        
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workerListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PerfilesTopTableViewCell", for: indexPath) as! PerfilesTopTableViewCell
            cell.titleLbl.text = "Planillas:"
            cell.descriptionLbl.text = "Gestiona la plantilla de tu personal"
            return cell
            
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerTableViewCell", for: indexPath) as! WorkerTableViewCell
            let obj = self.workerListArray[indexPath.row] as! DataSnapshot
            cell.jobProfileTitleLbl.text = "\(obj.childSnapshot(forPath: "job_profile_name").value as? String ?? "") \( obj.childSnapshot(forPath: "job_profile_surname").value as? String ?? "")"
            cell.jobNameLbl.text = "Cargo: \( obj.childSnapshot(forPath: "job_profile_job_name").value as? String ?? "")"
            
            cell.jobAreaLbl.text = "Area: \( obj.childSnapshot(forPath: "job_profile_area").value as? String ?? "")"
            
            cell.indexPath = indexPath
            cell.delegate = self
            cell.selectionStyle = .none
            
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 95
        } else {
            return 105
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK:- Delegate Methods
    func settingButtonTapped(indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Evaluation360DetailsViewController") as! Evaluation360DetailsViewController
        
        let obj = self.workerListArray[indexPath.row] as! DataSnapshot
        let job_profile_name = obj.childSnapshot(forPath: "job_profile_name").value as? String ?? ""
        let job_profile_surname = obj.childSnapshot(forPath: "job_profile_surname").value as? String ?? ""

        let job_profile_job_name =  obj.childSnapshot(forPath: "job_profile_job_name").value as? String ?? ""
        let job_profile_area = obj.childSnapshot(forPath: "job_profile_area").value as? String ?? ""
        let job_profile_denomition = obj.childSnapshot(forPath: "job_profile_denomition").value as? String ?? ""
        let job_profile_immediate_boss = obj.childSnapshot(forPath: "job_profile_immediate_boss").value as? String ?? ""
        let job_profile_responsable_area = obj.childSnapshot(forPath: "job_profile_responsable_area").value as? String ?? ""
        let job_profile_people_number = obj.childSnapshot(forPath: "job_profile_people_number").value as? String ?? ""
        let job_profile_job_mission = obj.childSnapshot(forPath: "job_profile_job_mission").value as? String ?? ""
        let job_profile_job_mission_description =  obj.childSnapshot(forPath: "job_profile_job_mission_description").value as? String ?? ""
        
        let dict = ["job_profile_name": job_profile_name,
                    "job_profile_surname": job_profile_surname,
                    "job_profile_job_name": job_profile_job_name,
                    "job_profile_area": job_profile_area,
                    "job_profile_denomition": job_profile_denomition,
                    "job_profile_immediate_boss": job_profile_immediate_boss, "job_profile_responsable_area": job_profile_responsable_area,
                    "job_profile_people_number": job_profile_people_number, "job_profile_job_mission": job_profile_job_mission, "job_profile_job_mission_description": job_profile_job_mission_description, "Worker_Id": obj.key, "Compnay_Id": self.companyId]
        
        UserDefaults.standard.setValue(dict, forKey: "PROFILEDICT")
        nextViewController.companyDetailDict = companyDetailDict
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //MARK:- Get Worked List
    func getWorkerList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Job Profile")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.workerListArray = array
                self.workerListArray.insert("", at: 0)
                print("Arrayyy is \(self.workerListArray)")
                self.tbl.delegate = self
                self.tbl.dataSource = self
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    
    
}
