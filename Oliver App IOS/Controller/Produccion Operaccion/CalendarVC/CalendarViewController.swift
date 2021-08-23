//
//  CalendarViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 13/03/21.
//

import UIKit

protocol addCalendarDelegate: class {
    func callAddCalendar(match: String, value: String)
}

class CalendarViewController: UIViewController {
    var daysArray = Array<Any>()
    var monthArray = Array<Any>()
    var yearArray = Array<Any>()
    var hourArray = Array<Any>()
    var minuteArray = Array<Any>()
    let calendar = Calendar.current
    let date = Date()
    var currentYear = Int()
    var matchTable = String()
    var localArray = Array<Any>()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tbl: UITableView!
    weak var delegateAddCalendar: addCalendarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
        self.daysArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
        self.monthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
        self.hourArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","00"]
        self.minuteArray = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
        self.currentYear =  Calendar.current.component(.year, from: Date())
        for index  in 0 ..< 100
        {
            self.yearArray.append(String(format: "%d",  currentYear - index))
        }
        
        if matchTable == "Date" {
            txtSearch.text = ""
            localArray = daysArray
            matchTable = "Date"
            tbl.reloadData()
        }
        if matchTable == "Month" {
            txtSearch.text = ""
            localArray = monthArray
            matchTable = "Month"
            tbl.reloadData()
        }
        if matchTable == "Year" {
             txtSearch.text = ""
            localArray = yearArray
            matchTable = "Year"
            tbl.reloadData()
        }
        if matchTable == "Hour" {
            txtSearch.text = ""
            matchTable = "Hour"
            tbl.reloadData()
       }
        if matchTable == "Minute" {
             txtSearch.text = ""
             matchTable = "Minute"
             tbl.reloadData()
        }
    }
    
    @IBAction func txtSearch(_ sender: Any) {
        if(matchTable == "Date")
        {
            self.daysArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.daysArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                daysArray = localArray
            }
        }
        
        if(matchTable == "Month")
        {
            self.monthArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.monthArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                monthArray = localArray
            }
        }
        
        if(matchTable == "Year")
        {
            self.yearArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.yearArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                yearArray = localArray
            }
        }
        tbl.reloadData()
   }
}


extension CalendarViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(matchTable == "Date")
        {
            return  self.daysArray.count
        }
        else if(matchTable == "Month")
        {
            return  self.monthArray.count
        }
        else if(matchTable == "Year")
        {
            return  self.yearArray.count
        }
        else if(matchTable == "Hour")
        {
            return  self.hourArray.count
        }
        else if(matchTable == "Minute")
        {
            return  self.minuteArray.count
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
            delegateAddCalendar?.callAddCalendar(match: "Date", value:  self.daysArray[indexPath.row] as? String ?? "")
        }
        if(matchTable == "Month")
        {
            delegateAddCalendar?.callAddCalendar(match: "Month", value:  self.monthArray[indexPath.row] as? String ?? "")
        }
        if(matchTable == "Year")
        {
            delegateAddCalendar?.callAddCalendar(match: "Year", value:  self.yearArray[indexPath.row] as? String ?? "")
        }
        if(matchTable == "Hour")
        {
            delegateAddCalendar?.callAddCalendar(match: "Hour", value:  self.hourArray[indexPath.row] as? String ?? "")
        }
        if(matchTable == "Minute")
        {
            delegateAddCalendar?.callAddCalendar(match: "Minute", value:  self.minuteArray[indexPath.row] as? String ?? "")
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*******************************Search *********************************/
    
  
  }




