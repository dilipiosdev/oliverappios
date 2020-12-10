//
//  NegociosListViewController.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit
import JGProgressHUD
import Firebase
class NegociosListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var subViewButton: UIView!
    @IBOutlet var subView: UIView!
    @IBOutlet var tbl: UITableView!
    var comapnyListArray = Array<Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.subView.layer.addSublayer(GlobleClass.backGroundColor())
        self.subViewButton.layer.addSublayer(GlobleClass.backGroundColor())
        subViewButton.layer.cornerRadius = 5
        subViewButton.clipsToBounds = true
        /******************** Register Table Cell ****************************/
            tbl.register(UINib(nibName: "NegociosTableViewCell", bundle: nil), forCellReuseIdentifier:  "NegociosTableViewCell")
        

    }
    override func viewWillAppear(_ animated: Bool) {
        manageView()
    }
    
    func manageView() -> Void {
        self.comapnyListArray.removeAll()
        getCompanyList()
    }

    func  getCompanyList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let companyArray = snapshot.children.allObjects as? Array<Any>
            {
                for item  in companyArray {
                    let dict = item as! DataSnapshot
                    self.comapnyListArray.append(dict)
                }
                
                hud.dismiss()
                print(companyArray)
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    // Mark:- TableView Delegate Method

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.comapnyListArray.count
    
    }
  
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: NegociosTableViewCell = self.tbl.dequeueReusableCell(withIdentifier: "NegociosTableViewCell") as! NegociosTableViewCell
        cell.btnGestionar.addTarget(self, action: #selector(gestionarMethod(_:)), for: UIControl.Event.touchUpInside)
        let dict = self.comapnyListArray[indexPath.row] as! DataSnapshot
        let companyImage = dict.childSnapshot(forPath: "company_image").value as? String ?? ""
        let image:UIImage = UIImage(named: "back")!
        let url = NSURL(string: companyImage)
        
        cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
        cell.lblComapanyName.text = dict.childSnapshot(forPath: "company_name").value as? String ?? ""
        cell.lblId.text = dict.childSnapshot(forPath: "company_ruc").value as? String ?? ""
        cell.lblVerfication.text =  String(format: "Verificacion: %@", dict.childSnapshot(forPath: "company_verification").value as? String ?? "")

        return cell
    }
  
    @objc func gestionarMethod(_ sender:UIButton) -> Void {
        let  point = sender.convert(CGPoint.zero, to: tbl)
        let indexPath = tbl.indexPathForRow(at: point)
        if(indexPath != nil)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompanyHomeViewController") as! CompanyHomeViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    @IBAction func buttonNegocios(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NegociosRegisterViewController") as! NegociosRegisterViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
}
