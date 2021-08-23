//
//  AddRegisterAdquisicionVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 05/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddRegisterAdquisicionVC: UIViewController {
    var companyId = String()
    var companyDetailDict = DataSnapshot()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
