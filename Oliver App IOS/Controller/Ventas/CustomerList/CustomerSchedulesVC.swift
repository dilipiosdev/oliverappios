//
//  CustomerSchedulesVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 09/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class CustomerSchedulesVC: UIViewController {
    var companyDetailDict = DataSnapshot()
    var customerDetailDict = DataSnapshot()

    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()
    var hourArray = Array<Any>()
    var minuteArray = Array<Any>()

    var currentYear = Int()
    var localArray = Array<Any>()
    var matchTable = String()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tbl: UITableView!
    @IBOutlet var subViewTable: UIView!
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblMonth: UILabel!
    @IBOutlet var lblYear: UILabel!
    @IBOutlet var lblHour: UILabel!
    @IBOutlet var lblMinute: UILabel!
    var companyID = String()
    let calendar = Calendar.current
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyID = companyDetailDict.key
        daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        hourArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","00"]
        minuteArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]

        currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            yearArray.append(String(format: "%d",  currentYear - index))
        }
        subViewTable.isHidden = true
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
    }
    
    
    @IBAction func buttonDate(_ sender: Any) {
        txtSearch.text = ""
        localArray = daysArray
        matchTable = "Date"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    @IBAction func buttonMonth(_ sender: Any) {
        txtSearch.text = ""
        localArray = monthArray
        matchTable = "Month"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    @IBAction func buttonYear(_ sender: Any) {
         txtSearch.text = ""
        localArray = yearArray
        matchTable = "Year"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    @IBAction func buttonHour(_ sender: Any) {
          txtSearch.text = ""
        localArray = hourArray
        matchTable = "Hour"
        subViewTable.isHidden = false
        tbl.reloadData()
        
        
    }
    @IBAction func buttonMinute(_ sender: Any) {
         txtSearch.text = ""
        localArray = minuteArray
        matchTable = "Minute"
        subViewTable.isHidden = false
        tbl.reloadData()
    }
    
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonSubClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonSubmit(_ sender: Any) {
   
        if(lblDate.text?.isEmpty == true || lblMonth.text?.isEmpty == true || lblYear.text?.isEmpty == true || lblHour.text?.isEmpty == true || lblMonth.text?.isEmpty == true || lblDate.text == "Dia" || lblDate.text == "Mes" || lblDate.text == "Año" || lblDate.text == "Hora" || lblDate.text == "Minutos" )
        {
            let alertView: UIAlertController = UIAlertController(title: "Message!", message: "Debes ingresar el mesde la cita", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        let timestamp = NSDate().timeIntervalSince1970
        let timeStampString = String(format: "%.0f",timestamp)

        let dict:[AnyHashable : Any] = [
            "customer_id": customerDetailDict.key,
            "customer_name": customerDetailDict.childSnapshot(forPath: "customer_name").value as? String ?? "",
            "date": String(format: "%@/%@/%@", lblDate.text ?? "",lblMinute.text ?? "",lblYear.text ?? ""),
            "schedule_state": "pending",
            "time": String(format: "%@:%@", lblHour.text ?? "",lblMinute.text ?? ""),
            "timestamp": timeStampString,
        ]
        Database.database().reference().child("My Companies").child(companyID).child("Customer Schedules")
            .child(timeStampString).updateChildValues(dict)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
    
extension CustomerSchedulesVC : UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(matchTable == "Date")
        {
            return  daysArray.count
        }
        else if(matchTable == "Month")
        {
            return  monthArray.count
        }
        else if(matchTable == "Year")
        {
            return  yearArray.count
        }
        else if(matchTable == "Hour")
        {
            return  monthArray.count
        }
        else if(matchTable == "Minute")
        {
            return  yearArray.count
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RegisterTableViewCell = self.tbl.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as! RegisterTableViewCell
        cell.selectionStyle = .none
        cell.subViewSearch.layer.cornerRadius = 5
        cell.subViewSearch.clipsToBounds = true
        if(matchTable == "Date")
        {
            cell.lblText.text = daysArray[indexPath.row] as? String
            
        }
        else if(matchTable == "Month")
        {
            cell.lblText.text = monthArray[indexPath.row] as? String
            
        }
        else if(matchTable == "Year")
        {
            cell.lblText.text = String(format: "%@", yearArray[indexPath.row] as! String)
            
        }
        else if(matchTable == "Hour")
        {
            cell.lblText.text = hourArray[indexPath.row] as? String
            
        }
        else if(matchTable == "Minute")
        {
            cell.lblText.text = String(format: "%@", minuteArray[indexPath.row] as! String)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(matchTable == "Date")
        {
            subViewTable.isHidden = true
            lblDate.text = daysArray[indexPath.row] as? String
            
            return
        }
        if(matchTable == "Month")
        {
            subViewTable.isHidden = true
            lblMonth.text = monthArray[indexPath.row] as? String
           
            return
        }
        if(matchTable == "Year")
        {
            
            subViewTable.isHidden = true
            lblYear.text = String(format: "%@",  yearArray[indexPath.row] as! String)
           
            return
        }
        if(matchTable == "Hour")
        {
            subViewTable.isHidden = true
            lblHour.text = hourArray[indexPath.row] as? String
           
            return
        }
        if(matchTable == "Minute")
        {
            
            subViewTable.isHidden = true
            lblMinute.text = String(format: "%@",  minuteArray[indexPath.row] as! String)
           
            return
        }
     
    }
  }

