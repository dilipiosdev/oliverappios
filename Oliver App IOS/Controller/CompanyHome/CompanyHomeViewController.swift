//
//  CompanyViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 05/12/20.
//

import UIKit

class CompanyHomeViewController: UIViewController {
    @IBOutlet var subView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.subView.layer.addSublayer(GlobleClass.backGroundColor())
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonNegocios(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyHomeDetailVC") as! CompanyHomeDetailVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    

}
