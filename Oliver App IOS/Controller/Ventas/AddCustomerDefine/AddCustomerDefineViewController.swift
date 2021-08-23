//
//  AddCustomerDefineViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 10/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class AddCustomerDefineViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyID = String()
    var customerDetailDict = DataSnapshot()

    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var subView3: UIView!
    @IBOutlet weak var subView4: UIView!
    @IBOutlet weak var subView5: UIView!

    @IBOutlet weak var buttonSi1: UIButton!
    @IBOutlet weak var buttonSi2: UIButton!
    @IBOutlet weak var buttonSi3: UIButton!
    @IBOutlet weak var buttonSi4: UIButton!
    @IBOutlet weak var buttonSi5: UIButton!
    
    @IBOutlet weak var buttonNo1: UIButton!
    @IBOutlet weak var buttonNo2: UIButton!
    @IBOutlet weak var buttonNo3: UIButton!
    @IBOutlet weak var buttonNo4: UIButton!
    @IBOutlet weak var buttonNo5: UIButton!
    
    var customerDefine = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subView2.isHidden = true
        subView3.isHidden = true
        subView4.isHidden = true
        subView5.isHidden = true
        companyID = companyDetailDict.key
        customerDefine = "contact"
        buttonNo1.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonSi1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buttonSi1(_ sender: Any) {
        buttonSi1.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonNo1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = false
        subView3.isHidden = true
        subView4.isHidden = true
        subView5.isHidden = true
        customerDefine = "interested"

    }
    @IBAction func buttonSi2(_ sender: Any) {
        buttonSi2.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonNo2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = false
        subView3.isHidden = false
        subView4.isHidden = true
        subView5.isHidden = true
        customerDefine = "prospect"

    }
    @IBAction func buttonSi3(_ sender: Any) {
        buttonSi3.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonNo3.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = false
        subView3.isHidden = false
        subView4.isHidden = true
        subView5.isHidden = true
        customerDefine = "prospect"

    }
    @IBAction func buttonSi4(_ sender: Any) {
        buttonSi4.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonNo4.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = false
        subView3.isHidden = false
        subView4.isHidden = false
        subView5.isHidden = false
        customerDefine = "final"

    }
    @IBAction func buttonSi5(_ sender: Any) {
        buttonSi5.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonNo5.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        customerDefine = "customer"

    }
    
    
    @IBAction func buttonNo1(_ sender: Any) {
        buttonNo1.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonSi1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = true
        subView3.isHidden = true
        subView4.isHidden = true
        subView5.isHidden = true
        customerDefine = "contact"


    }
    
    @IBAction func buttonNo2(_ sender: Any) {
        buttonNo2.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonSi2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = false
        subView3.isHidden = true
        subView4.isHidden = true
        subView5.isHidden = true
        customerDefine = "interested"
    }
    
    @IBAction func buttonNo3(_ sender: Any) {
        buttonNo3.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonSi3.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = false
        subView3.isHidden = false
        subView4.isHidden = false
        subView5.isHidden = true
        customerDefine = "potencial"

    }
    
    @IBAction func buttonNo4(_ sender: Any) {
        buttonNo4.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonSi4.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subView2.isHidden = false
        subView3.isHidden = false
        subView4.isHidden = false
        subView5.isHidden = true
        customerDefine = "potencial"

    }
    
    @IBAction func buttonNo5(_ sender: Any) {
        buttonNo5.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        buttonSi5.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        customerDefine = "contact"

    }
    
    
    @IBAction func buttonSubmit(_ sender: Any) {
        let dict:[AnyHashable : Any] = [
            "customer_define": customerDefine,
        ]
        Database.database().reference().child("My Companies").child(companyDetailDict.key).child("Customers")
            .child(customerDetailDict.key).updateChildValues(dict)
        self.dismiss(animated: true, completion: nil)
    }
    
}
