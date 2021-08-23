//
//  AddOrdenesProductDetailsVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 20/03/21.
//

import UIKit
import JGProgressHUD
import Firebase
class AddOrdenesProductDetailsVC: UIViewController {
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    var productObj = DataSnapshot()
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelProductName.text = String(format: productObj.childSnapshot(forPath: "product_name").value as? String ?? "0.00")
        let url = NSURL(string: String(format: "%@",productObj.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        productImage.af.setImage(withURL: url! as URL, placeholderImage: image)

    }
    

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
