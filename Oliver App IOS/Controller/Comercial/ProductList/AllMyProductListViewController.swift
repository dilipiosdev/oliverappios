//
//  AllMyProductListViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 22/01/21.
//

import UIKit
import Firebase
import JGProgressHUD

class AllMyProductListViewController: UIViewController, ProtocolDelegate {
 
    
    var productListArray = Array<Any>()
    @IBOutlet weak var tblMyProduct: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyIDValue = String()
    
    var matchView = String()
    var selectIndex = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        companyIDValue = companyDetailDict.key

        
        tblMyProduct.register(UINib(nibName: "MyProductTableViewCell", bundle: nil), forCellReuseIdentifier: "MyProductTableViewCell")
        self.productListArray.removeAll()
        tblMyProduct.reloadData()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyIDValue)").child("My Products")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.productListArray.removeAll()
                self.productListArray = array
                hud.dismiss()
                self.tblMyProduct.reloadData()
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
    @IBAction func buttonAddProduct(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddMyProductViewController") as! AddMyProductViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
}


//MARK:- TableView Methods
extension AllMyProductListViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return productListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProductTableViewCell", for: indexPath) as! MyProductTableViewCell
            let obj = self.productListArray[indexPath.row] as! DataSnapshot
            cell.lblName.text = String(format: "%@",obj.childSnapshot(forPath: "product_name").value as? String ?? "")
            
            let url = NSURL(string: String(format: "%@",obj.childSnapshot(forPath: "product_image").value as? String ?? ""))
            cell.lblPrice.text = String(format: "S/ %@",obj.childSnapshot(forPath: "product_price").value as? String ?? "0.00")
            let image:UIImage = UIImage(named: "back")!
            cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
            cell.selectionStyle = .none
            return cell
     
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(matchView == "AddProduct")
        {
            let obj = self.productListArray[indexPath.row] as! DataSnapshot

            let saveKey = String(format: "Product%d", (selectIndex+1))
            Database.database().reference().child("My Companies").child(companyIDValue).child("Module 6").child("Matrix 10").child(saveKey).updateChildValues([
                "item1": false,
                "item2": false,
                "item3": false,
                "item4": false,
                "item5": false,
                "product_id": obj.key,
          ])
            self.dismiss(animated: true, completion: nil)

        }
        else if(matchView == "AddProductCompany")
        {
            let obj = self.productListArray[indexPath.row] as! DataSnapshot

            let saveKey = String(format: "Product%d", (selectIndex+1))
            Database.database().reference().child("My Companies").child(companyIDValue).child("Module 6").child("Matrix 10 Companies").child(saveKey).updateChildValues([
                "item1": false,
                "item2": false,
                "item3": false,
                "item4": false,
                "item5": false,
                "product_id": obj.key,
          ])
            self.dismiss(animated: true, completion: nil)

        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddQuinityViewController") as! AddQuinityViewController
            nextViewController.companyDetailDict = companyDetailDict
            nextViewController.modalPresentationStyle = .overFullScreen
            nextViewController.addQuinityObj = self.productListArray[indexPath.row] as! DataSnapshot
            nextViewController.delegateAddQuintity = self
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func popViewMethod() {
        self.dismiss(animated: true, completion: nil)
    }
}
