//
//  AddMisExistenciasViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 27/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddMisExistenciasViewController: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var wareHousesKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn1(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddMyProductViewController") as! AddMyProductViewController
        nextViewController.matchView = "WareHouses"
        nextViewController.wareHouseID = wareHousesKey
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
      
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func btn2(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllMyProductListViewController") as! AllMyProductListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchView = "AddProduct"
        nextViewController.selectIndex = sender.tag
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


