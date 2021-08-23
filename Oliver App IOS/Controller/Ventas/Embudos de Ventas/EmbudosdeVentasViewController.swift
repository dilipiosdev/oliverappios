//
//  EmbudosdeVentasViewController.swift
//  Oliver App IOS
//
//  Created by apple on 06/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
class EmbudosdeVentasViewController: UIViewController,UIScrollViewDelegate {
    var customerListArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var tbl1: UITableView!
    var arrayCustomerType = ["Contactos","Interesados","Prospectos","Potenciales","Finalistas","Clientes"]
    var count1 = 0
    var count2 = 0
    var count3 = 0
    var count4 = 0
    var count5 = 0
    var count6 = 0
    var arrayCustomerCount = Array<Int>()
    @IBOutlet weak var buttonAgendar: UIButton!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayCustomerCount.append(count1)
        arrayCustomerCount.append(count2)
        arrayCustomerCount.append(count3)
        arrayCustomerCount.append(count4)
        arrayCustomerCount.append(count5)
        arrayCustomerCount.append(count6)
        lbl1.isHidden = false
        lbl2.isHidden = true

        tbl.register(UINib(nibName: "DestinatarioTableViewCell", bundle: nil), forCellReuseIdentifier: "DestinatarioTableViewCell")
        tbl1.register(UINib(nibName: "EmbudosTableViewCell", bundle: nil), forCellReuseIdentifier: "EmbudosTableViewCell")
        companyId = companyDetailDict.key
        getCustomerList()
    }
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonAgendar(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCustomerViewController") as! AddCustomerViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func getCustomerList() -> Void {
        self.customerListArray.removeAll()
        self.tbl.reloadData()
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyId)").child("Customers")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.customerListArray.removeAll()
                for item  in array {
                    let dict = item as! DataSnapshot
                    self.customerListArray.append(dict)
                    let type = String(format: "%@",dict.childSnapshot(forPath: "customer_define").value as? String ?? "")
                    if type == "contact" {
                        self.count1 = self.count1 + 1
                    } else if type == "interested" {
                        self.count2 = self.count2 + 1
                    } else if type == "prospect" {
                        self.count3 = self.count3 + 1
                    } else if type == "potencial" {
                        self.count4 = self.count4 + 1
                    } else if type == "final" {
                        self.count5 = self.count5 + 1
                    } else if type == "customer" {
                        self.count6 = self.count6 + 1
                    }
                    self.arrayCustomerCount.removeAll()
                    self.arrayCustomerCount.append(self.count1)
                    self.arrayCustomerCount.append(self.count2)
                    self.arrayCustomerCount.append(self.count3)
                    self.arrayCustomerCount.append(self.count4)
                    self.arrayCustomerCount.append(self.count5)
                    self.arrayCustomerCount.append(self.count6)
                    self.tbl1.reloadData()
                }
                hud.dismiss()
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth:CGFloat = scrollView.frame.width
            let current:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        if current == 0 {
            buttonAgendar.isHidden = false
        } else {
            buttonAgendar.isHidden = true
        }
    }
    
    
    @IBAction func btn1(_ sender: Any) {
        lbl1.isHidden = false
        lbl2.isHidden = true
        scrollToPage(page: 0, animated: true)

    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollview.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollview.scrollRectToVisible(frame, animated: animated)
    }
    @IBAction func btn2(_ sender: Any) {
        lbl2.isHidden = false
        lbl1.isHidden = true
        scrollToPage(page: 1, animated: true)

    }
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageWidth: CGFloat = scrollView.frame.width
            let current: CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            print(current)
        if current == 0{
            lbl1.isHidden = false
            lbl2.isHidden = true

        } else {
            lbl2.isHidden = false
            lbl1.isHidden = true
        }
        self.scrollToPage(page: Int(current), animated: true)
    }
    
 
}
//MARK:- TableView Methods
extension EmbudosdeVentasViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl {
             return customerListArray.count
        } else {
             return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tbl {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DestinatarioTableViewCell", for: indexPath) as! DestinatarioTableViewCell
            let obj = self.customerListArray[indexPath.row] as! DataSnapshot
            cell.lblName.text = obj.childSnapshot(forPath: "customer_name").value as? String ?? ""
            cell.lblNumber.text = String(format: "Telefono: %@",obj.childSnapshot(forPath: "customer_phone").value as? String ?? "")
            cell.lblEmail.text = String(format: "Correo: %@",obj.childSnapshot(forPath: "customer_email").value as? String ?? "")
            cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
            cell.lblTipo.text = String(format: "Tipo: %@",obj.childSnapshot(forPath: "customer_type").value as? String ?? "")
            cell.selectionStyle = .none
            cell.buttonDefinir.isHidden = false
            cell.buttonDefiniarConst.constant = 40
            cell.buttonDefinir.addTarget(self,action:#selector(addCustomerDefine),for:.touchUpInside)
            cell.buttonDefinir.tag = indexPath.row
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmbudosTableViewCell", for: indexPath) as! EmbudosTableViewCell
            cell.lblCustomerType.text = arrayCustomerType[indexPath.row]
            cell.lblCount.text = String(format: "%d",arrayCustomerCount [indexPath.row])
            let totalCustomer = arrayCustomerCount[0] + arrayCustomerCount[1] + arrayCustomerCount[2] + arrayCustomerCount[3] + arrayCustomerCount[4] + arrayCustomerCount[5]
            
            if totalCustomer > 0
            {
              let count = arrayCustomerCount[indexPath.row]
              let persent = Double(count * 100) / Double(totalCustomer)
              cell.lblPersent.text = String(format: "%.2f%@", persent,"%")
            }
            cell.selectionStyle = .none
            cell.buttonSearch.addTarget(self,action:#selector(buttonSearch),for:.touchUpInside)
            cell.buttonSearch.tag = indexPath.row
            return cell
        }
    }
    @objc func addCustomerDefine(sender:UIButton) -> Void
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCustomerDefineViewController") as! AddCustomerDefineViewController
        let obj = self.customerListArray[sender.tag] as! DataSnapshot
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.customerDetailDict = obj
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @objc func buttonSearch(sender:UIButton) -> Void
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Ventas", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerListViewController") as! CustomerListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        if sender.tag == 0 {
            nextViewController.customer_define = "contact"
        } else if sender.tag == 1 {
            nextViewController.customer_define = "interested"
        } else if sender.tag == 2 {
            nextViewController.customer_define = "prospect"
        } else if sender.tag == 3 {
            nextViewController.customer_define = "potencial"
        } else if sender.tag == 4 {
            nextViewController.customer_define = "final"
        } else if sender.tag == 5 {
            nextViewController.customer_define = "customer"
        }
        self.present(nextViewController, animated: true, completion: nil)
    }
    
 }
