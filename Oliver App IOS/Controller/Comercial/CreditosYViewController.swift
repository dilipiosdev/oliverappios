//
//  CreditosYViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 20/12/20.
//

import UIKit
import Firebase
import JGProgressHUD

class CreditosYViewController: UIViewController {
    @IBOutlet weak var subViewBlack: UIView!
    @IBOutlet weak var subViewGreen: UIView!
    @IBOutlet weak var subViewRed: UIView!
    @IBOutlet weak var subViewMain: UIView!
    @IBOutlet weak var subViewMain1: UIView!
    @IBOutlet weak var subViewMain2: UIView!
    @IBOutlet weak var subViewMain3: UIView!
    @IBOutlet weak var subViewMain4: UIView!

    @IBOutlet weak var tblCurrentPaid: UITableView!
    @IBOutlet weak var tblNoPaid: UITableView!
    @IBOutlet weak var subViewMainTop: UIView!
    @IBOutlet weak var tblContactList: UITableView!
    var companyDetailDict = DataSnapshot()
    var companyIDValue = String()
    var customerListArray = Array<Any>()
    var paidBillListArray = Array<Any>()
    var noPaidBillListArray = Array<Any>()
    @IBOutlet weak var collView: UICollectionView!
    
    let calendar = Calendar.current
    let date = Date()
    var day = Int()
    var month = Int()
    var year = Int()
    @IBOutlet weak var lblExpairTotle: UILabel!
    @IBOutlet weak var lblnoPaidTotal: UILabel!
    @IBOutlet weak var lblMainTotal: UILabel!
    var expairPaidTotal = Double()
    var noPaidTotal = Double()
    
    @IBOutlet weak var lblMonto1: UILabel!
    @IBOutlet weak var lblMonto2: UILabel!
    @IBOutlet weak var lblMonto3: UILabel!
    @IBOutlet weak var lblMonto4: UILabel!
    @IBOutlet weak var lblMonto5: UILabel!
    @IBOutlet weak var lblMonto6: UILabel!
    @IBOutlet weak var lblMonto7: UILabel!

    @IBOutlet weak var lblPersent1: UILabel!
    @IBOutlet weak var lblPersent2: UILabel!
    @IBOutlet weak var lblPersent3: UILabel!
    @IBOutlet weak var lblPersent4: UILabel!
    @IBOutlet weak var lblPersent5: UILabel!
    @IBOutlet weak var lblPersent6: UILabel!
    @IBOutlet weak var lblPersent7: UILabel!
    
    
    var montoValue2 = 0.00
    var montoValue3 = 0.00
    var montoValue4 = 0.00
    var montoValue5 = 0.00
    var montoValue6 = 0.00
    var montoValue7 = 0.00
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyIDValue = companyDetailDict.key
        manageView()

    }
    
    func manageView()  {
        let obj = UpdateCornerRadious()
        obj.subViewCornerRadious10(subViewArray: [subViewBlack,subViewGreen,subViewRed])
        self.subViewMain.layer.addSublayer(GlobleClass.backGrayGroundColor())
        collView.register(UINib(nibName: "LabelTitleCVC", bundle: nil), forCellWithReuseIdentifier: "LabelTitleCVC")
        tblContactList.register(UINib(nibName: "CreditoContactTableViewCell", bundle: nil), forCellReuseIdentifier: "CreditoContactTableViewCell")
        
        tblCurrentPaid.register(UINib(nibName: "EmisionDeBoletasTVC", bundle: nil), forCellReuseIdentifier: "EmisionDeBoletasTVC")
        
        tblNoPaid.register(UINib(nibName: "EmisionDeBoletasTVC", bundle: nil), forCellReuseIdentifier: "EmisionDeBoletasTVC")
        getCustomerList()
        getPaidBillsList()
        getPaidBillsExpairList()
    }
  
    
    /************************GET CUSTOMER List ************************************/
    func getCustomerList() -> Void {
        self.customerListArray.removeAll()
        self.tblContactList.reloadData()
       
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Customers")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                for item  in array {
                    let dict = item as! DataSnapshot
                    let uid = dict.childSnapshot(forPath: "customer_type").value as? String ?? ""
                    if(uid == "Persona")
                    {
                        self.customerListArray.append(dict)
                    }
                }
                hud.dismiss()
                self.tblContactList.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    /************************GET Paid Bill List ************************************/
    func getPaidBillsList() -> Void {
        self.paidBillListArray.removeAll()
        self.tblCurrentPaid.reloadData()
        
        self.lblMonto2.text = String(format: "S/ %.2f", 0.00)
        self.lblMonto3.text = String(format: "S/ %.2f", 0.00)
        self.lblMonto4.text = String(format: "S/ %.2f", 0.00)
        self.lblMonto5.text = String(format: "S/ %.2f", 0.00)
        self.lblMonto6.text = String(format: "S/ %.2f", 0.00)
        self.lblMonto7.text = String(format: "S/ %.2f", 0.00)
        
        self.lblPersent2.text = String(format: "0.00 %")
        self.lblPersent3.text = String(format: "0.00 %")
        self.lblPersent4.text = String(format: "0.00 %")
        self.lblPersent5.text = String(format: "0.00 %")
        self.lblPersent6.text = String(format: "0.00 %")
        self.lblPersent7.text = String(format: "0.00 %")
        
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let timeStrSave = String(format: "%d-%d-%d", components.day!,components.month!,components.year!)
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("My Bills")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.paidBillListArray.removeAll()
                for item  in array {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let currentDate = dateFormatter.date(from: timeStrSave)
                    let dict = item as! DataSnapshot
                    let state = dict.childSnapshot(forPath: "state").value as? String ?? ""
                    let yearStr = dict.childSnapshot(forPath: "expiration_year").value as? String ?? ""
                    let monthStr = dict.childSnapshot(forPath: "expiration_month").value as? String ?? ""
                    let dayStr = dict.childSnapshot(forPath: "expiration_day").value as? String ?? ""
                    let dateStr = String(format: "%@-%@-%@", dayStr,monthStr,yearStr)
                    let expairDate = dateFormatter.date(from: dateStr)

                    if((state == "no_paid") && (currentDate!.compare(expairDate!) == .orderedAscending))
                    {
                        self.paidBillListArray.append(dict)
                        self.noPaidTotal += Double(dict.childSnapshot(forPath: "bill_amount").value as? String ?? "") ?? 0
           
                      
                        self.tblCurrentPaid.reloadData()
                    }
                }
                self.lblnoPaidTotal.text = String(format: "S/ %.2f", self.noPaidTotal)
                self.lblMainTotal.text = String(format: "S/ %.2f", (self.noPaidTotal + self.expairPaidTotal))
                self.lblMonto1.text =  String(format: "S/ %.2f", self.noPaidTotal)
                self.lblPersent1.text =  String(format: "S/ %.2f", (self.noPaidTotal * 100)/(self.noPaidTotal + self.expairPaidTotal))

                hud.dismiss()
                self.tblCurrentPaid.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
  
    
    /************************GET Paid Bill Expain List ************************************/
    func getPaidBillsExpairList() -> Void {
        self.paidBillListArray.removeAll()
        self.tblCurrentPaid.reloadData()
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let timeStrSave = String(format: "%d-%d-%d", components.day!,components.month!,components.year!)
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("My Bills")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.noPaidBillListArray.removeAll()

                for item  in array {
                    let dict = item as! DataSnapshot
                    let state = dict.childSnapshot(forPath: "state").value as? String ?? ""
                    if(state == "expired")
                    {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        let currentDate = dateFormatter.date(from: timeStrSave)
                        let dict = item as! DataSnapshot
                        let state = dict.childSnapshot(forPath: "state").value as? String ?? ""
                        let yearStr = dict.childSnapshot(forPath: "expiration_year").value as? String ?? ""
                        let monthStr = dict.childSnapshot(forPath: "expiration_month").value as? String ?? ""
                        let dayStr = dict.childSnapshot(forPath: "expiration_day").value as? String ?? ""
                        let dateStr = String(format: "%@-%@-%@", dayStr,monthStr,yearStr)
                        let expairDate = dateFormatter.date(from: dateStr)
                        
                        
                        self.noPaidBillListArray.append(dict)
                        self.expairPaidTotal += Double(dict.childSnapshot(forPath: "bill_amount").value as? String ?? "") ?? 0
                        self.tblNoPaid.reloadData()
                        let component = self.calendar.dateComponents([.day], from:expairDate! , to: currentDate!)
                        self.setMontoValue(billAmount: Double(dict.childSnapshot(forPath: "bill_amount").value as? String ?? "") ?? 0, days: component.day!)
                    }
                }
                self.lblExpairTotle.text = String(format: "S/ %.2f", self.expairPaidTotal)
                self.lblMainTotal.text = String(format: "S/ %.2f", (self.noPaidTotal + self.expairPaidTotal))
                self.lblPersent1.text =  String(format: "S/ %.2f", (self.noPaidTotal * 100)/(self.noPaidTotal + self.expairPaidTotal))
                hud.dismiss()
                self.tblNoPaid.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    func setMontoValue(billAmount: Double, days: Int) -> Void {
     
        print(day)
        if(days >= 1 && days <= 8)
        {
            montoValue2 += billAmount
            self.lblMonto2.text = String(format: "S/ %.2f", montoValue2)
            self.lblPersent2.text = String(format: "%.2f", (self.montoValue2 * 100)/(self.noPaidTotal + self.expairPaidTotal)) + " %"
        }
        else  if(days >= 9 && days <= 15)
        {
            montoValue3 += billAmount
            self.lblMonto3.text = String(format: "S/ %.2f", montoValue3)
            self.lblPersent3.text = String(format: "%.2f\("%")", (self.montoValue3 * 100)/(self.noPaidTotal + self.expairPaidTotal)) + " %"
        }
        else  if(days >= 16 && days <= 30)
        {
            montoValue4 += billAmount
            self.lblMonto4.text = String(format: "S/ %.2f", montoValue4)
            self.lblPersent4.text = String(format: "%.2f\("%")", (self.montoValue4 * 100)/(self.noPaidTotal + self.expairPaidTotal)) + " %"
        }
        else  if(days >= 31 && days <= 45)
        {
            montoValue5 += billAmount
            self.lblMonto5.text = String(format: "S/ %.2f", montoValue5)
            self.lblPersent5.text = String(format: "%.2f\("%")", (self.montoValue5 * 100)/(self.noPaidTotal + self.expairPaidTotal)) + " %"
        }
        else  if(days >= 46 && days <= 60)
        {
            montoValue6 += billAmount
            self.lblMonto6.text = String(format: "S/ %.2f", montoValue6)
            self.lblPersent6.text = String(format: "%.2f\("%")", (self.montoValue6 * 100)/(self.noPaidTotal + self.expairPaidTotal)) + " %"
        }
        else  if(days >= 61)
        {
            montoValue7 += billAmount
            self.lblMonto7.text = String(format: "S/ %.2f", montoValue7)
            self.lblPersent7.text = String(format: "%.2f", (self.montoValue7 * 100)/(self.noPaidTotal + self.expairPaidTotal)) + " %"
        }
        
    }
    @IBAction func buttonAddCustomer(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCustomerViewController") as! AddCustomerViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(nextViewController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func buttonNotification(_ sender: Any) {
        let obj = self.noPaidBillListArray[0] as! DataSnapshot

        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SendEmailViewController") as! SendEmailViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.customerDetailDict = obj
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
      
    }

}
//MARK:- CollectionView Methods
extension CreditosYViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelTitleCVC", for: indexPath) as! LabelTitleCVC
        if(indexPath.row == 0 || indexPath.row == 1)
        {
            cell.lblName.isHidden = false
            cell.imgView.isHidden = true
        }
        else
        {
            cell.lblName.isHidden = true
            cell.imgView.isHidden = false
        }
        if(indexPath.row == 0)
        {
            cell.lblName.text = "VIGENTES"
        }
        if(indexPath.row == 1)
        {
            cell.lblName.text = "VENCIDOS"
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
    UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 80 , height: 44 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToPage(page: indexPath.row, animated: true)

    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
   
}
extension CreditosYViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblCurrentPaid )
        {
            return self.paidBillListArray.count
        }
        else if(tableView == tblNoPaid )
        {
            return self.noPaidBillListArray.count
        }
        
        return customerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tblCurrentPaid )
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmisionDeBoletasTVC", for: indexPath) as! EmisionDeBoletasTVC
            let obj = self.paidBillListArray[indexPath.row] as! DataSnapshot
            cell.lblBilID.text = obj.childSnapshot(forPath: "bill_id").value as? String ?? ""
            cell.lblCustomerName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
            cell.lblBillAmount.text = String(format: "S/ %@", obj.childSnapshot(forPath: "bill_amount").value as? String ?? "0.00")
            cell.selectionStyle = .none
            
            let statuStr = obj.childSnapshot(forPath: "state").value as? String ?? ""
            if(statuStr.uppercased() == "NO_PAID")
            {
                cell.bottomButtonheightConst.constant = 30
                cell.buttonBottom.isHidden = false
            }
            else if (statuStr.uppercased() == "PAID")
            {
                cell.bottomButtonheightConst.constant = 0
                cell.buttonBottom.isHidden = true
            }
            cell.buttonBottom.addTarget(self,action:#selector(buttonPaidBottom),for:.touchUpInside)
            cell.buttonBottom.tag = indexPath.row
            return cell
        }
        else if tableView == tblNoPaid {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmisionDeBoletasTVC", for: indexPath) as! EmisionDeBoletasTVC
            let obj = self.noPaidBillListArray[indexPath.row] as! DataSnapshot
            cell.lblBilID.text = obj.childSnapshot(forPath: "bill_id").value as? String ?? ""
            cell.lblCustomerName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
            cell.lblBillAmount.text = String(format: "S/ %@", obj.childSnapshot(forPath: "bill_amount").value as? String ?? "0.00")
            cell.selectionStyle = .none
            
            let statuStr = obj.childSnapshot(forPath: "state").value as? String ?? ""
            if(statuStr.uppercased() == "NO_PAID")
            {
                cell.bottomButtonheightConst.constant = 30
                cell.buttonBottom.isHidden = false
            }
            else if (statuStr.uppercased() == "PAID")
            {
                cell.bottomButtonheightConst.constant = 0
                cell.buttonBottom.isHidden = true
            }
            cell.buttonBottom.addTarget(self,action:#selector(buttonExpairBottom),for:.touchUpInside)
            cell.buttonBottom.tag = indexPath.row
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreditoContactTableViewCell", for: indexPath) as! CreditoContactTableViewCell
            let obj = self.customerListArray[indexPath.row] as! DataSnapshot
            cell.lblName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
            cell.lblNumber.text = String(format: "Telefono: %@",obj.childSnapshot(forPath: "customer_phone").value as? String ?? "")
            cell.lblEmail.text = String(format: "Correo: %@",obj.childSnapshot(forPath: "customer_email").value as? String ?? "")
            cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
            cell.selectionStyle = .none
            cell.buttonEvaluacion.addTarget(self,action:#selector(buttonEvaluacion),for:.touchUpInside)
            cell.buttonEvaluacion.tag = indexPath.row
            cell.lblEvlution.text = String(format: "Credito Aprobado: S/ %@", "0.00")

            if(obj.key.isEmpty == false)
            {
              DispatchQueue.main.async {
                   let userRef =
                    Database.database().reference().child("My Companies").child(self.companyIDValue).child("Customers")
                    .child(obj.key).child("Internal Evaluation")
                  userRef.observe(.value) { (snapshot) in
                    if let dict = snapshot.value as? Dictionary<String,Any>
                    {
                        let evlutionStr = dict["customer_max_credit"] as? String ?? ""
                        cell.lblEvlution.text = String(format: "Credito Aprobado: S/ %@", evlutionStr)

                    }
                  }
              }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    @objc func buttonPaidBottom(sender:UIButton) -> Void
    {
        let obj = self.paidBillListArray[sender.tag] as! DataSnapshot
        Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("My Bills").child(obj.key).updateChildValues([
            "state" : "paid"
        ])
    }
    @objc func buttonExpairBottom(sender:UIButton) -> Void
    {
        let obj = self.noPaidBillListArray[sender.tag] as! DataSnapshot
        Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("My Bills").child(obj.key).updateChildValues([
            "state" : "paid"
        ])
    }
    @objc func buttonEvaluacion(sender:UIButton) -> Void
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EvaluacionViewController") as! EvaluacionViewController
        let obj = self.customerListArray[sender.tag] as! DataSnapshot

        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.customerIDValue = obj.key
        nextViewController.customerName = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""

        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    

}
