//
//  AlmacenamientoVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 25/02/21.
//

import UIKit
import FirebaseDatabase
import JGProgressHUD
class AlmacenamientoAddVC: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var warehousesKey = String()
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    var warehouse_destination = ""
    @IBOutlet weak var txtNombre: UITextField!
    let calender = Calendar.current
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn1(_ sender: Any) {
        btn1.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        btn2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        warehouse_destination = "products"

    }
    @IBAction func btn2(_ sender: Any) {
        btn2.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        btn1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        warehouse_destination = "materials"

    }
    @IBAction func buttonRegister(_ sender: Any) {
        
        let timestamp = NSDate().timeIntervalSince1970
        let timeStampString = String(format: "%.0f",timestamp)
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let dateStr = String(format: "%d-%d-%d", components.year ?? 0 ,components.month ?? 0,components.day ?? 0)
        let dateTime = String(format: "%d-%d-%d", components.hour ?? 0 ,components.minute ?? 0,components.second ?? 0)
        warehousesKey = dateStr + dateTime

        Database.database().reference().child("My Companies/\(companyId)").child("Warehouses").child(warehousesKey).updateChildValues([
            "timestamp" : timeStampString,
            "warehouse_destination" : warehouse_destination,
            "warehouse_name" : txtNombre.text ?? "",
            "warehouse_register_date" : dateStr,
            "warehouse_register_time" : dateTime,
        ])
        self.dismiss(animated: true, completion: nil)
    }
    
}
