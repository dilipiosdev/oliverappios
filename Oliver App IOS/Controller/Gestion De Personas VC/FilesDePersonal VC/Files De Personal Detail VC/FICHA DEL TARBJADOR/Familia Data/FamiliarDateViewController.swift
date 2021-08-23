//
//  BirthDateViewController.swift
//  Oliver App IOS
//
//  Created by apple on 14/03/21.
//

import UIKit
import Firebase
import JGProgressHUD


class FamiliarDataViewController: UIViewController, addCalendarDelegate, TableListDelegate {
    
    func callTableViewList(match: String, value: String) {
        print("Match \(match)  Value \(value)")
        
        
        if match == "Familiar" {
            self.familiarBtn.setTitle(value, for: .normal)
            
        }
        if match == "Civil" {
            self.familiarCivilBtn.setTitle(value, for: .normal)
            
        }
        
        
    }
    
    func callAddCalendar(match: String, value: String) {
        if(match == "Date")
        {
            lblDate.text = value
            return
        }
        if(match == "Month")
        {
            lblMonth.text = value
            return
        }
        if(match == "Year")
        {
            lblYear.text = value
            return
        }
    }
    
    @IBOutlet weak var tbl: UITableView!
    var matchTable = String()
    
    var familiarArray = Array<Any>()
    var civilStateArray = Array<Any>()
    @IBOutlet var yesBtn: UIButton!
    @IBOutlet var noBtn: UIButton!
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    var yesNoStr = String()
    
    @IBOutlet var familiarBtn: UIButton!
    @IBOutlet var familiarCivilBtn: UIButton!
    @IBOutlet var  districtBtn: UIButton!
    @IBOutlet var documentoBtn: UIButton!
    
    @IBOutlet var familiarNameTF: UITextField!
    @IBOutlet var documentNumberTF: UITextField!
    var company_Id = String()
    var worker_Id = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.familiarArray = ["CONYUGE", "CONCUBINA", "CONCUBINO", "HIJO", "HIJA"]
        self.civilStateArray = ["SOLTERO", "CASADO", "VIUDO", "DIVORCIADO"]
        self.yesBtn.backgroundColor = UIColor.white
        self.noBtn.backgroundColor = UIColor.white
        
    }
    
    
    @IBAction func buttonDate(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Date"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonMonth(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Month"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    @IBAction func buttonYear(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Year"
        nextViewController.delegateAddCalendar = self
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonSelectFamiliar(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Familiar"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.familiarArray
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    @IBAction func buttonSelectCivil(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TableListViewController") as! TableListViewController
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchTable = "Civil"
        nextViewController.delegateTableList = self
        nextViewController.commonArray =  self.civilStateArray
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    @IBAction func yesBtnTapped(_ sender: Any) {
        self.yesBtn.backgroundColor = UIColor.darkGray
        self.noBtn.backgroundColor = UIColor.white
        self.yesNoStr = "Si"
        
    }
    
    @IBAction func noBtnTapped(_ sender: Any) {
        self.yesBtn.backgroundColor = UIColor.white
        self.noBtn.backgroundColor = UIColor.darkGray
        self.yesNoStr = "No"
        
    }
    
    
    
    
    @IBAction func registerInfoBtnTapped(_ sender: Any) {
        
        let timestamp = NSDate().timeIntervalSince1970
        let requestTimeStamp = String(format: "%.2f",timestamp)
        let timeStampString = String(format: "%.0f",timestamp)
        
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        
        let dict:[AnyHashable : Any] = [
            "familiar_bth_day": self.lblDate.text!,
            "familiar_bth_month": self.lblMonth.text!,
            "familiar_bth_year": self.lblYear.text!,
            "familiar_name" : self.familiarNameTF.text!,
            "familiar_type" : self.familiarBtn.titleLabel!.text!,
            "familiar_bth_civil_state": self.familiarCivilBtn.titleLabel!.text!,
            "familiar_document_number": self.documentNumberTF.text!,
            "familiar_same_address": self.yesNoStr,
            "timestamp": requestTimeStamp
            
        ]
        print(dict)
        Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile")
            .child(self.worker_Id).child("Personal File").child("Familiars").child(timeStampString).updateChildValues(dict)
        self.dismiss(animated: true, completion: nil)
        
    }
}

