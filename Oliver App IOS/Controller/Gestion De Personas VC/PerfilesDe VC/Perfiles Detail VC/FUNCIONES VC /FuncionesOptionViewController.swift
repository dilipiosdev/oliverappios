//
//  FuncionesOptionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
import Firebase
import JGProgressHUD

class FuncionesOptionViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var company_Id = String()
    var worker_Id = String()
    var functionListArray = Array<Any>()
    @IBOutlet var subViewbg: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViewbg.layer.cornerRadius = 5
        subViewbg.clipsToBounds = true
        subViewbg.layer.masksToBounds = false
        subViewbg.layer.shadowColor = UIColor.lightGray.cgColor
        subViewbg.backgroundColor = UIColor.white
        subViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        subViewbg.layer.shadowOpacity = 0.5
        tbl.register(UINib(nibName: "FunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "FunctionTableViewCell")
        self.getFunctionList()
    }
    
    @IBAction func registerFunctionBtnTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FunctionRegisterViewController") as! FunctionRegisterViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.worker_Id = self.worker_Id
        nextViewController.company_Id = self.company_Id
        self.present(nextViewController, animated: true, completion: nil)
                                             
      }
    
    
    //MARK:- UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.functionListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FunctionTableViewCell", for: indexPath) as! FunctionTableViewCell
        let obj = self.functionListArray[indexPath.row] as! DataSnapshot
        
        cell.funcDescriptionLbl.text =  obj.childSnapshot(forPath: "function_description").value as? String ?? ""
        
        cell.functionScoreLbl.text = obj.childSnapshot(forPath: "function_score").value as? String ?? ""
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK:- Get Worked List
    func getFunctionList() -> Void {
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(self.company_Id)").child("Job Profile/\(self.worker_Id)").child("Functions")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.functionListArray = array
                print("functionListArray is \(self.functionListArray)")
                self.tbl.delegate = self
                self.tbl.dataSource = self
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
}
