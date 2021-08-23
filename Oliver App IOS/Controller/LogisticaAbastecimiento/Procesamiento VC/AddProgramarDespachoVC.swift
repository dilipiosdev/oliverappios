//
//  AddProgramarDespachoVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 26/03/21.
//

import UIKit
import JGProgressHUD
import Firebase

class AddProgramarDespachoVC: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
