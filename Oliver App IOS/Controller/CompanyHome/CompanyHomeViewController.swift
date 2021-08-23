//
//  CompanyViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 05/12/20.
//

import UIKit
import Firebase

class CompanyHomeViewController: UIViewController {
    @IBOutlet var subView: UIView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.subView.layer.addSublayer(GlobleClass.backGrayGroundColor())
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonNegocios(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyHomeDetailVC") as! CompanyHomeDetailVC
        nextViewController.companyDetailDict = companyDetailDict
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    

}
