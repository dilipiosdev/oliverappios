//
//  SporteAClientViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 25/12/20.
//

import UIKit
import Firebase
import JGProgressHUD
import MessageUI

class SporteAClientViewController: UIViewController, MFMailComposeViewControllerDelegate{
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var tbl: UITableView!
    var companyDetailDict = DataSnapshot()
    var userListArray = Array<Any>()
    var companyIDValue = String()
    
    @IBOutlet weak var lblDiaria: UILabel!
    @IBOutlet weak var lblSemanal: UILabel!
    @IBOutlet weak var lblMensual: UILabel!
    @IBOutlet weak var lblTrimestral: UILabel!
    @IBOutlet weak var lblSemestral: UILabel!
    @IBOutlet weak var lblAnul: UILabel!
    
    @IBOutlet weak var lblPoint1: UILabel!
    @IBOutlet weak var lblPoint2: UILabel!
    @IBOutlet weak var lblPoint3: UILabel!
    @IBOutlet weak var lblPoint4: UILabel!
    @IBOutlet weak var lblPoint5: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var discount1 = String()
    var discount2 = String()
    var discount3 = String()
    var discount4 = String()
    var discount5 = String()

    var enviarStrValue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyIDValue = companyDetailDict.key
        manage()
        getCustomerList()
        getCustomerPointList()

    }
    func manage() -> Void {
        tbl.register(UINib(nibName: "CreditoContactTableViewCell", bundle: nil), forCellReuseIdentifier: "CreditoContactTableViewCell")
    }
    
    
    func getCustomerPointList()  {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
      
            
        let userRef =
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Module 6").child("Customer Points").child("Points")
        userRef.observe(.value) { (snapshot) in
        hud.dismiss()
         if let dict =  snapshot.value as? Dictionary<String,Any>
         {
            self.lblDiaria.text = dict["points1"] as? String ?? ""
            self.lblSemanal.text = dict["points2"] as? String ?? ""
            self.lblMensual.text = dict["points3"] as? String ?? ""
            self.lblTrimestral.text = dict["points4"] as? String ?? ""
            self.lblSemestral.text = dict["points5"] as? String ?? ""
            self.lblAnul.text = dict["points6"] as? String ?? ""

         }
        }
        
        let userRef1 = Database.database().reference().child("My Companies/\(companyIDValue)").child("Module 6").child("Customer Points").child("Discounts")
        userRef1.observe(.value) { (snapshot) in
        hud.dismiss()
         if let dict =  snapshot.value as? Dictionary<String,Any>
         {
            self.discount1 = (dict["discount1"] as? String ?? "0")
            self.discount2 = (dict["discount2"] as? String ?? "0")
            self.discount3 = (dict["discount3"] as? String ?? "0")
            self.discount4 = (dict["discount4"] as? String ?? "0")
            self.discount5 = (dict["discount5"] as? String ?? "0")

            self.lblPoint1.text = (dict["discount1"] as? String ?? "0") + "%"
            self.lblPoint2.text = (dict["discount2"] as? String ?? "0") + "%"
            self.lblPoint3.text = (dict["discount3"] as? String ?? "0") + "%"
            self.lblPoint4.text = (dict["discount4"] as? String ?? "0") + "%"
            self.lblPoint5.text = (dict["discount5"] as? String ?? "0") + "%"

         }
        }
    }
    
    func getCustomerList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)

     
        let userRef =
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Customers")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
        {
            self.userListArray.removeAll()
            self.userListArray = array
            self.tbl.reloadData()
            hud.dismiss()
            self.tbl.reloadData()
         }
         else
         {
                hud.dismiss()
         }
      }
    }
    @IBAction func button1(_ sender: Any) {
        scrollToPage(page: 0, animated: true)
    }
   

    @IBAction func button2(_ sender: Any) {
        scrollToPage(page: 1, animated: true)
    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func buttonDiaria(_ sender: Any) {
        callSavingMethod(matchType: "FRECUENCIA", matchIndex: "1")
    }
    @IBAction func buttonSemanal(_ sender: Any) {
        callSavingMethod(matchType: "FRECUENCIA", matchIndex: "2")
    }
    @IBAction func buttonMensual(_ sender: Any) {
        callSavingMethod(matchType: "FRECUENCIA", matchIndex: "3")
    }
    @IBAction func buttonTrimeStral(_ sender: Any) {
        callSavingMethod(matchType: "FRECUENCIA", matchIndex: "4")
    }
    @IBAction func buttonSemeStral(_ sender: Any) {
        callSavingMethod(matchType: "FRECUENCIA", matchIndex: "5")
    }
    @IBAction func buttonAnual(_ sender: Any) {
        callSavingMethod(matchType: "FRECUENCIA", matchIndex: "6")
    }

    @IBAction func buttonPoint1(_ sender: Any) {
        callSavingMethod(matchType: "PUNTAJES", matchIndex: "1")
    }
    @IBAction func buttonPoint2(_ sender: Any) {
        callSavingMethod(matchType: "PUNTAJES", matchIndex: "2")
    }
    @IBAction func buttonPoint3(_ sender: Any) {
        callSavingMethod(matchType: "PUNTAJES", matchIndex: "3")
    }
    @IBAction func buttonPoint4(_ sender: Any) {
        callSavingMethod(matchType: "PUNTAJES", matchIndex: "4")
    }
    @IBAction func buttonPoint5(_ sender: Any) {
        callSavingMethod(matchType: "PUNTAJES", matchIndex: "5")
    }
    
    func callSavingMethod(matchType: String, matchIndex: String) -> Void {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddSoporteViewController") as! AddSoporteViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.matchType = matchType
        nextViewController.matchIndex = matchIndex
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    
  
    
    
    
    
    
    
}
//MARK:- TableView Methods
extension SporteAClientViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditoContactTableViewCell", for: indexPath) as! CreditoContactTableViewCell
        let obj = self.userListArray[indexPath.row] as! DataSnapshot
        cell.lblName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
        cell.lblNumber.text = String(format: "Telefono: %@",obj.childSnapshot(forPath: "customer_phone").value as? String ?? "")
        cell.lblEmail.text = String(format: "Correo: %@",obj.childSnapshot(forPath: "customer_email").value as? String ?? "")
        cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
        cell.selectionStyle = .none
        cell.subViewButton.isHidden = false
        cell.buttonAsignar.addTarget(self,action:#selector(buttonAsignar),for:.touchUpInside)
        cell.buttonEnviar.addTarget(self,action:#selector(buttonEnviar),for:.touchUpInside)
        cell.buttonAsignar.tag = indexPath.row
        cell.buttonEnviar.tag = indexPath.row
        
        cell.lblEvlution.text = String(format: "Puntos Acumulados: S/ %@", "0.00")

        if(obj.key.isEmpty == false)
        {
          DispatchQueue.main.async {
               let userRef =
                Database.database().reference().child("My Companies").child(self.companyIDValue).child("Customers").child(obj.key)
              userRef.observe(.value) { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String,Any>
                {
                    let evlutionStr = Int(dict["customer_points"] as? String ?? "0") ?? 0
                    cell.lblEvlution.text = String(format: "Puntos Acumulados: S/ %d", evlutionStr)
                }
             }
          }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    @objc func buttonAsignar(sender:UIButton) -> Void
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddSoporteViewController") as! AddSoporteViewController
        let obj = self.userListArray[sender.tag] as! DataSnapshot
        nextViewController.customerIDValue = obj.key
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchType = "ASIGNAR"
        nextViewController.customerName = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
        self.present(nextViewController, animated: true, completion: nil)
    }
    @objc func buttonEnviar(sender:UIButton) -> Void
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddSoporteViewController") as! AddSoporteViewController
        let obj = self.userListArray[sender.tag] as! DataSnapshot
        nextViewController.customerIDValue = obj.key
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchType = "ENVIAR"
        nextViewController.customerName = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
        if(obj.key.isEmpty == false)
        {
          DispatchQueue.main.async {
               let userRef =
                Database.database().reference().child("My Companies").child(self.companyIDValue).child("Customers").child(obj.key)
            userRef.observeSingleEvent(of: .value) { (snapshot) in
                var evlutionStr = 0
                if let dict = snapshot.value as? Dictionary<String,Any>
                {
                    evlutionStr = Int(dict["customer_points"] as? String ?? "0") ?? 0
                    if evlutionStr >= 0 && evlutionStr <= 5 {
                        self.enviarStrValue = self.discount1
                    } else if evlutionStr >= 6 && evlutionStr <= 10 {
                        self.enviarStrValue = self.discount2
                    } else if evlutionStr >= 11 && evlutionStr <= 50 {
                        self.enviarStrValue = self.discount3
                    }  else if evlutionStr >= 51 && evlutionStr <= 100 {
                        self.enviarStrValue = self.discount4
                    }  else if evlutionStr >= 101 {
                        self.enviarStrValue = self.discount5
                    }
                }
                nextViewController.discountValueStr = self.enviarStrValue
                nextViewController.pointStr =  String(format: "%d", evlutionStr) 
                nextViewController.customerDetailDict = obj
                self.present(nextViewController, animated: true, completion: nil)
             }
          }
        }
    }
}
