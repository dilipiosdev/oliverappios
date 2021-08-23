//
//  PerfileOptionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
import Firebase
import JGProgressHUD


class PerfileOptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var workerListArray = Array<Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tbl.register(UINib(nibName: "PerOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "PerOptionTableViewCell")
    }
    
    
    
    //MARK:- UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                cell.jobProfileTitleLbl.text = dict["job_profile_name"]
                cell.jobNameLbl.text =  dict["job_profile_job_name"]
            }
                    
            return cell
            
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PerOptionTableViewCell", for: indexPath) as! PerOptionTableViewCell
            
            if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
                cell.jobAreaLbl.text = dict["job_profile_area"]
                cell.denominationLbl.text =  dict["job_profile_denomition"]
                cell.immediateBossLbl.text = dict["job_profile_immediate_boss"]
                cell.responsableAreaLbl.text =  dict["job_profile_responsable_area"]
                cell.peopleNoLbl.text = dict["job_profile_people_number"]
                cell.jobMissionLbl.text =  dict["job_profile_job_mission"]
                cell.jobMissionDescriptionLbl.text =  dict["job_profile_job_mission_description"]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 125
        } else {
            return 440
        }
    }
    
}
