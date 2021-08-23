//
//  HomeViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 26/11/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.subView.layer.addSublayer(GlobleClass.backGroundColor()) 

    }
    


    @IBAction func buttonNegocios(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NegociosListViewController") as! NegociosListViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
  
    
}
