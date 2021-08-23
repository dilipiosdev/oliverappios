//
//  RegistroDelVentasVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 20/12/20.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistroDelVentasVC: UIViewController {
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var subViewMainTop: UIView!
    @IBOutlet weak var subViewMain: UIView!
    @IBOutlet weak var buttonBoleta: UIButton!
    @IBOutlet weak var buttonFactura: UIButton!
    @IBOutlet weak var buttonVetas: UIButton!
    var billListArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    @IBOutlet weak var subViewCredito: UIView!
    var buttonType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageView()
        getBillList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subViewCredito.isHidden = true
    }
    
    func manageView()  {
        self.subViewMain.layer.addSublayer(GlobleClass.backGrayGroundColor())
        tbl.register(UINib(nibName: "EmisionDeBoletasTVC", bundle: nil), forCellReuseIdentifier: "EmisionDeBoletasTVC")
        getBillList()
   }
    
    func getBillList() -> Void {
        self.billListArray.removeAll()
        tbl.reloadData()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("My Bills")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.billListArray.removeAll()
                self.billListArray = array
                hud.dismiss()
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
    @IBAction func buttonBoleta(_ sender: Any) {
        
        subViewCredito.isHidden = false
        buttonType = "BOLETA"

    }
    
    @IBAction func buttonFactura(_ sender: Any) {
        subViewCredito.isHidden = false
        buttonType = "FACTURA"

    }
    @IBAction func buttonVentas(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DashBoardVentasVC") as! DashBoardVentasVC
        nextViewController.companyDetailDict = companyDetailDict
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBAction func buttonCloseCredito(_ sender: Any) {
        subViewCredito.isHidden = true
    }
    
    @IBAction func buttonContado(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllCreditoViewController") as! AllCreditoViewController
         nextViewController.companyDetailDict = companyDetailDict
        nextViewController.creditType = "CONTADO"
        nextViewController.buttonType = buttonType
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBAction func buttonCardito(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllCreditoViewController") as! AllCreditoViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.creditType = "CREDITO"
        nextViewController.buttonType = buttonType
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
  
    
    
}



//MARK:- TableView Methods
extension RegistroDelVentasVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.billListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmisionDeBoletasTVC", for: indexPath) as! EmisionDeBoletasTVC
        let obj = self.billListArray[indexPath.row] as! DataSnapshot
        cell.lblBilID.text = obj.childSnapshot(forPath: "bill_id").value as? String ?? ""
        cell.lblCustomerName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
        cell.lblBillAmount.text = String(format: "S/ %@", obj.childSnapshot(forPath: "bill_amount").value as? String ?? "0.00")
        cell.selectionStyle = .none
        
        let statuStr = obj.childSnapshot(forPath: "state").value as? String ?? ""
        var setStatusStr = String()
        if(statuStr.uppercased() == "PAID")
        {
            setStatusStr = "PAGADO"
            cell.buttonBottom.isHidden = true
            cell.bottomButtonheightConst.constant = 0
        }
        else if(statuStr.uppercased() == "PAID")
        {
            setStatusStr = "VIGENTE"
            cell.buttonBottom.isHidden = false
            cell.bottomButtonheightConst.constant = 30
        }
        else
        {
            setStatusStr = "VENCIDO"
            cell.buttonBottom.isHidden = false
            cell.bottomButtonheightConst.constant = 30
        }
        cell.lblState.text =  setStatusStr
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    

}
