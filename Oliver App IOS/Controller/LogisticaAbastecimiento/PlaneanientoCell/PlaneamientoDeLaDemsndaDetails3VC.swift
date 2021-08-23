//
//  PlaneamientoDeLaDemsndaDetails3VC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 24/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class PlaneamientoDeLaDemsndaDetails3VC: UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var productObj = DataSnapshot()
    var monthArray = Array<Any>()
    let calender = Calendar.current
    let date = Date()
    var dic11 = Dictionary<String,Any>()

    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        monthArray = ["ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"]
        tbl.register(UINib(nibName: "Proyeccion3TableViewCell", bundle: nil), forCellReuseIdentifier: "Proyeccion3TableViewCell")
        
        lblProductName.text = productObj.childSnapshot(forPath: "product_name").value as? String ?? ""

        let url = NSURL(string: String(format: "%@",productObj.childSnapshot(forPath: "product_image").value as? String ?? ""))
        let image:UIImage = UIImage(named: "back")!
        imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
        
        getProductList()
    }
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("My Products").child(productObj.key)
        userRef.observe(.value) { [self] (snapshot) in
            if let dic = snapshot.value as? Dictionary<String,Any>
            {
                self.dic11 = dic
                self.tbl.reloadData()
                hud.dismiss()

            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension PlaneamientoDeLaDemsndaDetails3VC : UITabBarDelegate,UITableViewDataSource
{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return 12
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tbl.dequeueReusableCell(withIdentifier: "Proyeccion3TableViewCell", for: indexPath) as! Proyeccion3TableViewCell
        cell.lbl.text = monthArray[indexPath.row] as? String
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let quintityKey = String(format: "%d%dquantity_projection",components.year! + 1 , indexPath.row + 1)
        let saleKey = String(format: "%d%dsales_projection",components.year! + 1, indexPath.row + 1)
        let quinityValue = String(format: "%d", dic11[quintityKey] as? Int ?? 0)
        cell.txt1.text = quinityValue
        let saleValue = String(format: "%.2f", Double((dic11[saleKey] as? Int ?? 0)/1000))
        cell.txt2.text = saleValue
        return cell
        
    }
  
}


