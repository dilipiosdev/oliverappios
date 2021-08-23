//
//  DashBoardVentasVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 07/01/21.
//

import UIKit
import Firebase
import JGProgressHUD
class MatrizProductVC: UIViewController {

    @IBOutlet weak var collectionCropPaging: UIScrollView!
    var companyDetailDict = DataSnapshot()
    var arrayProductList = Array<Any>()
    var janValue = Double()
    var febValue = Double()
    var marValue = Double()
    var aprilValue = Double()
    var mayValue = Double()
    var junValue = Double()
    var julyValue = Double()
    var augValue = Double()
    var sepValue = Double()
    var octValue = Double()
    var novValue = Double()
    var decValue = Double()
    let calendar = Calendar.current
    let date = Date()
    
    var productByMonthArray = Array<DataSnapshot>()
    var customerByPurchaseArray = Array<DataSnapshot>()
    var monthProductTotle = Double()
    var purchhasedTotle = Double()
    var chartArray = [Int]()
    @IBOutlet weak var collView1: UICollectionView!
    @IBOutlet weak var collView2: UICollectionView!
    var companyIDValue = String()
    var myProductListArray = Array<Any>()
    var myProductCompanyListArray = Array<Any>()
    
    @IBOutlet weak var buttonMuy: UIButton!
    @IBOutlet weak var buttonBaje: UIButton!
    @IBOutlet weak var buttonMedip: UIButton!
    @IBOutlet weak var buttonAlto: UIButton!
    
    @IBOutlet weak var textVW1: UITextView!
    @IBOutlet weak var textVW2: UITextView!
    @IBOutlet weak var textVW3: UITextView!
    @IBOutlet weak var textVW4: UITextView!


 
    var seleteNaivalStr = String()

    @IBOutlet weak var subViewProductMatrix: UIView!
    
    @IBOutlet weak var lblProductTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViewProductMatrix.isHidden = true
        collView1.register(UINib(nibName: "MartizCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MartizCollectionViewCell")
        collView2.register(UINib(nibName: "MartizeCompanyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MartizeCompanyCollectionViewCell")
        companyIDValue = companyDetailDict.key
        myProductListArray = ["","","","","","","","","",""]
        getProductList()
        getProductListCompany()
        getProductMatrizData()

    }
    
    
    func getProductList()  {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Module 6").child("Matrix 10")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<DataSnapshot>
            {
                self.myProductListArray = ["","","","","","","","","",""]

                for item in array {
                    let value = item.key as? String
                    let valueID = value?.replacingOccurrences(of: "Product", with: "")
                    if valueID == "1" {
                        self.myProductListArray[0] = item
                    }
                    if valueID == "2" {
                        self.myProductListArray[1] = item
                    }
                    if valueID == "3" {
                        self.myProductListArray[2] = item
                    }
                    if valueID == "4" {
                        self.myProductListArray[3] = item
                    }
                    if valueID == "5" {
                        self.myProductListArray[4] = item
                    }
                    if valueID == "6" {
                        self.myProductListArray[5] = item
                    }
                    if valueID == "7" {
                        self.myProductListArray[6] = item
                    }
                    if valueID == "8" {
                        self.myProductListArray[7] = item
                    }
                    if valueID == "9" {
                        self.myProductListArray[8] = item
                    }
                    if valueID == "10" {
                        self.myProductListArray[9] = item
                    }
                }
                self.collView1.reloadData()
                hud.dismiss()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    
    func getProductListCompany()  {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef =
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Module 6").child("Matrix 10 Companies")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<DataSnapshot>
            {
                self.myProductCompanyListArray = ["","","","","","","","","",""]

                for item in array {
                    let value = item.key as? String
                    let valueID = value?.replacingOccurrences(of: "Product", with: "")
                    if valueID == "1" {
                        self.myProductCompanyListArray[0] = item
                    }
                    if valueID == "2" {
                        self.myProductCompanyListArray[1] = item
                    }
                    if valueID == "3" {
                        self.myProductCompanyListArray[2] = item
                    }
                    if valueID == "4" {
                        self.myProductCompanyListArray[3] = item
                    }
                    if valueID == "5" {
                        self.myProductCompanyListArray[4] = item
                    }
                    if valueID == "6" {
                        self.myProductCompanyListArray[5] = item
                    }
                    if valueID == "7" {
                        self.myProductCompanyListArray[6] = item
                    }
                    if valueID == "8" {
                        self.myProductCompanyListArray[7] = item
                    }
                    if valueID == "9" {
                        self.myProductCompanyListArray[8] = item
                    }
                    if valueID == "10" {
                        self.myProductCompanyListArray[9] = item
                    }
                }
                self.collView2.reloadData()
                hud.dismiss()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    
    func getProductMatrizData() {
        let userRef =
            Database.database().reference().child("My Companies/\(companyIDValue)").child("Module 6").child("Product Matrix")
        userRef.observe(.value) { (snapshot) in
            self.subViewProductMatrix.isHidden = true
            if let dict =  snapshot.value as? Dictionary<String,Any>
            {
                let value = dict["matrix_id"] as? Int ?? 0
                if value > 0 {
                    self.subViewProductMatrix.isHidden = false
                    if(value == 1)
                    {
                        self.lblProductTitle.text = "La estrategia a utilizar es la de Penetración de Mercado con bajo riesgo al fracaso"
                    }
                    if(value == 2)
                    {
                        self.lblProductTitle.text = "La estrategia a utilizar es la de Desarrollo de Nuevo Producto con riesgo medio al fracaso."
                    }
                    if(value == 3)
                    {
                        self.lblProductTitle.text = "La estrategia a utilizar es la de Desarrollo de Nuevos Mercados con riesgo medio al fracaso."
                    }
                    if(value == 4)
                    {
                        self.lblProductTitle.text = "La estrategia a utilizar es la de Diversificación con riesgo alto al fracaso si no hay respaldo financiero para invertir."
                    }
                    self.subViewProductMatrix.isHidden = false
                }
                else
                {
                    self.subViewProductMatrix.isHidden = true
                }
            }
        }
    }
    

 
    

    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func firstRadioBtn(_ sender: Any) {
        seleteNaivalStr = "First"

               buttonMuy.backgroundColor = .blue
               buttonBaje.backgroundColor = .white
               buttonMedip.backgroundColor = .white
               buttonAlto.backgroundColor = .white
    }
    
    @IBAction func secondRadioBtn(_ sender: Any) {
        seleteNaivalStr = "Second"
               buttonMuy.backgroundColor = .white
               buttonBaje.backgroundColor = .blue
               buttonMedip.backgroundColor = .white
               buttonAlto.backgroundColor = .white
               
       }
    
    @IBAction func thirdRadioBtn(_ sender: Any) {
        seleteNaivalStr = "Third"
        buttonMuy.backgroundColor = .white
        buttonBaje.backgroundColor = .white
        buttonMedip.backgroundColor = .blue
        buttonAlto.backgroundColor = .white
       }
    @IBAction func fourthRadioBtn(_ sender: Any) {
        
            seleteNaivalStr = "Fourth"
              buttonMuy.backgroundColor = .white
              buttonBaje.backgroundColor = .white
              buttonMedip.backgroundColor = .white
              buttonAlto.backgroundColor = .blue
       }
    @IBAction func continueBtn(_ sender: Any) {
        subViewProductMatrix.isHidden = false
    }

    
    
    @IBAction func btn1(_ sender: Any) {
        scrollToPage(page: 0, animated: true)
    }
    @IBAction func btn2(_ sender: Any) {
        scrollToPage(page: 1, animated: true)
    }
    @IBAction func btn3(_ sender: Any) {
        scrollToPage(page: 2, animated: true)
    }
    @IBAction func btn4(_ sender: Any) {
        scrollToPage(page: 3, animated: true)
    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.collectionCropPaging.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.collectionCropPaging.scrollRectToVisible(frame, animated: animated)
    }
    
    
    @IBAction func buttonProductMatrix(_ sender: Any) {
        
        if seleteNaivalStr == "First" {
            self.textVW1.backgroundColor = UIColor.lightGray
            self.textVW2.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
             self.textVW3.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
             self.textVW4.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
            
        } else if seleteNaivalStr == "Second" {
            self.textVW2.backgroundColor = UIColor.lightGray
                      self.textVW1.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
                       self.textVW3.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
                       self.textVW4.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)

            
        } else if seleteNaivalStr == "Third" {
            self.textVW3.backgroundColor = UIColor.lightGray
            self.textVW2.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
            self.textVW1.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
            self.textVW4.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)

            
        } else if seleteNaivalStr == "Fourth" {
            self.textVW4.backgroundColor = UIColor.lightGray
            self.textVW1.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
            self.textVW3.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)
            self.textVW2.backgroundColor = UIColor(red: 226/255.0, green: 229/255.0, blue: 232/255.0, alpha: 1.0)

            
        }
        scrollToPage(page: 3, animated: true)
        
        var saveValue = Int()
        if seleteNaivalStr == "First" {
            saveValue = 1
            self.lblProductTitle.text = "La estrategia a utilizar es la de Penetración de Mercado con bajo riesgo al fracaso"
        }
        if seleteNaivalStr == "Second" {
            saveValue = 2
            self.lblProductTitle.text = "La estrategia a utilizar es la de Desarrollo de Nuevo Producto con riesgo medio al fracaso."
        }
        if seleteNaivalStr == "Third" {
            saveValue = 3
            self.lblProductTitle.text = "La estrategia a utilizar es la de Desarrollo de Nuevos Mercados con riesgo medio al fracaso."
        }
        if seleteNaivalStr == "Fourth" {
            saveValue = 4
            self.lblProductTitle.text = "La estrategia a utilizar es la de Diversificación con riesgo alto al fracaso si no hay respaldo financiero para invertir."
        }
      
        Database.database().reference().child("My Companies/\(companyIDValue)").child("Module 6").child("Product Matrix").updateChildValues([
            "matrix_id" : saveValue
        ])
    }
    
    
    @IBAction func buttonDeleteProductMatrix(_ sender: Any) {
        Database.database().reference().child("My Companies/\(companyIDValue)").child("Module 6").child("Product Matrix").removeValue()
        subViewProductMatrix.isHidden = true
        buttonMuy.backgroundColor = .white
        buttonBaje.backgroundColor = .white
        buttonMedip.backgroundColor = .white
        buttonAlto.backgroundColor = .white
    }
}




//MARK:- CollectionView Methods
extension MatrizProductVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collView1 {
            if(myProductListArray.count > 10)
            {
                return 10
            }
            return self.myProductListArray.count
        }
        else {
            if(myProductCompanyListArray.count > 10)
            {
                return 10
            }
            return myProductCompanyListArray.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collView1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MartizCollectionViewCell", for: indexPath) as! MartizCollectionViewCell
            cell.lblGender.text =  "DESCONOCIDO"
            cell.lblIngresos.text =  "DESCONOCIDO"
            cell.lblOccupation.text =  "DESCONOCIDO"
            cell.lblZona.text = "DESCONOCIDO"
            cell.lblTrabaha.text = "DESCONOCIDO"
            cell.lblEducativo.text = "DESCONOCIDO"
            cell.lblAge.text = "DESCONOCIDO"
            cell.imageProduct.image = UIImage(named: "PlusButton")
            cell.lblProductName.text = "Seleccionar Producto"
            
            let obj = self.myProductListArray[indexPath.row]  as? DataSnapshot
            let dict  = obj?.value as? Dictionary<String,Any>
            let productKey = dict?["product_id"] as? String ?? ""
            var peopelArray = Array<DataSnapshot>()
            if(productKey.count > 0)
            {
               DispatchQueue.main.async {
                let userRef1 =
                    Database.database().reference().child("My Companies/\(self.companyIDValue)").child("My Products").child(productKey)
                userRef1.observeSingleEvent(of: .value) { (snapshot) in
                    let dict = snapshot.value as? Dictionary<String,Any>
                    cell.lblProductName.text = dict?["product_name"] as? String ?? ""
                    let url = NSURL(string: String(format: "%@",dict?["product_image"] as? String ?? ""))
                    let image:UIImage = UIImage(named: "back")!
                    cell.imageProduct.af.setImage(withURL: url! as URL, placeholderImage: image)
                }
                
                
                let userRef =
                    Database.database().reference().child("My Companies/\(self.companyIDValue)").child("My Products").child(productKey).child("Buyers").child("People")
                userRef.observeSingleEvent(of: .value) { (snapshot) in
                    if let array = snapshot.children.allObjects as? Array<DataSnapshot>
                    {
                        peopelArray = array
                        peopelArray = peopelArray.sorted(by: {$0.childSnapshot(forPath: "quantity_purchased").value as? Double ?? 0.00 > $1.childSnapshot(forPath: "quantity_purchased").value as? Double ?? 0.00})
                        print(peopelArray)
                        if(peopelArray.count > 0)
                        {
                            let customer_obj = peopelArray[0] as? DataSnapshot
                            let customer_Key = customer_obj?.key
                            let userRef =
                                Database.database().reference().child("My Companies/\(self.companyIDValue)").child("Customers").child(customer_Key ?? "")
                            userRef.observeSingleEvent(of: .value) { (snapshot) in
                                let dict = snapshot.value as? Dictionary<String,Any>
                                cell.lblGender.text = dict?["customer_gender"] as? String ?? ""
                                cell.lblIngresos.text = dict?["customer_economic_level"] as? String ?? ""
                                cell.lblOccupation.text = dict?["customer_occupation"] as? String ?? ""
                                cell.lblZona.text = String(format: "%@/%@/%@", dict?["customer_department"] as? String ?? "",dict?["customer_occupation"] as? String ?? "",dict?["customer_occupation"] as? String ?? "")
                                cell.lblTrabaha.text = String(format: "%@/%@/%@", dict?["customer_work_department"] as? String ?? "",dict?["customer_work_district"] as? String ?? "",dict?["customer_work_province"] as? String ?? "")
                                cell.lblEducativo.text = dict?["customer_academic_degree"] as? String ?? ""
                                let yearValue = Int(dict?["customer_bth_year"] as? String ?? "0") ?? 0
                                let monthValue = Int(dict?["customer_bth_month"] as? String ?? "0") ?? 0
                                let components = self.calendar.dateComponents([.year,.month], from: self.date)
                                if yearValue > 0
                                {
                                    var ageValue = (components.year ?? 0) - yearValue
                                    if(ageValue > 0)
                                    {
                                        if(monthValue > (components.month ?? 0))
                                        {
                                            ageValue -= 1
                                        }
                                        cell.lblAge.text = String(format: "%d Años", ageValue)
                                    }
                                }
                          }
                       }
                    }
                }
              }
            }
            cell.buttonSelectProduct.addTarget(self,action:#selector(buttonSelectProduct),for:.touchUpInside)
            cell.buttonSelectProduct.tag = indexPath.row
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MartizeCompanyCollectionViewCell", for: indexPath) as! MartizeCompanyCollectionViewCell
            cell.lblGender.text =  "DESCONOCIDO"
            cell.lblOccupation.text =  "DESCONOCIDO"
            cell.lblEducativo.text = "DESCONOCIDO"
            cell.lblAge.text = "DESCONOCIDO"
            cell.imageProduct.image = UIImage(named: "PlusButton")
            cell.lblProductName.text = "Seleccionar Producto"
            
            let obj = self.myProductCompanyListArray[indexPath.row]  as? DataSnapshot
            let dict  = obj?.value as? Dictionary<String,Any>
            let productKey = dict?["product_id"] as? String ?? ""
            var peopelArray = Array<DataSnapshot>()
            if(productKey.count > 0)
            {
               DispatchQueue.main.async {
                let userRef1 =
                    Database.database().reference().child("My Companies/\(self.companyIDValue)").child("My Products").child(productKey)
                userRef1.observeSingleEvent(of: .value) { (snapshot) in
                    let dict = snapshot.value as? Dictionary<String,Any>
                    cell.lblProductName.text = dict?["product_name"] as? String ?? ""
                    let url = NSURL(string: String(format: "%@",dict?["product_image"] as? String ?? ""))
                    let image:UIImage = UIImage(named: "back")!
                    cell.imageProduct.af.setImage(withURL: url! as URL, placeholderImage: image)
                }
                
                
                let userRef =
                    Database.database().reference().child("My Companies/\(self.companyIDValue)").child("My Products").child(productKey).child("Buyers").child("Companies")
                userRef.observeSingleEvent(of: .value) { (snapshot) in
                    if let array = snapshot.children.allObjects as? Array<DataSnapshot>
                    {
                        peopelArray = array
                        peopelArray = peopelArray.sorted(by: {$0.childSnapshot(forPath: "quantity_purchased").value as? Double ?? 0.00 > $1.childSnapshot(forPath: "quantity_purchased").value as? Double ?? 0.00})
                        print(peopelArray)
                        if(peopelArray.count > 0)
                        {
                            let customer_obj = peopelArray[0] as? DataSnapshot
                            let customer_Key = customer_obj?.key
                            let userRef =
                                Database.database().reference().child("My Companies/\(self.companyIDValue)").child("Customers").child(customer_Key ?? "")
                            userRef.observeSingleEvent(of: .value) { (snapshot) in
                                let dict = snapshot.value as? Dictionary<String,Any>
                                cell.lblGender.text = dict?["customer_economic_activity"] as? String ?? ""
                               
                                
                                
                                cell.lblOccupation.text = String(format: "%@/%@/%@", dict?["customer_work_department"] as? String ?? "",dict?["customer_work_district"] as? String ?? "",dict?["customer_work_province"] as? String ?? "")
                            
                                let yearValue = Int(dict?["customer_bth_year"] as? String ?? "0") ?? 0
                                let monthValue = Int(dict?["customer_bth_month"] as? String ?? "0") ?? 0
                                let components = self.calendar.dateComponents([.year,.month], from: self.date)
                                if yearValue > 0
                                {
                                    var ageValue = (components.year ?? 0) - yearValue
                                    if(ageValue > 0)
                                    {
                                        if(monthValue > (components.month ?? 0))
                                        {
                                            ageValue -= 1
                                        }
                                        cell.lblEducativo.text = String(format: "%d Años", ageValue)
                                    }
                                }
                          }
                       }
                    }
                }
              }
            }
            cell.buttonSelectProduct.addTarget(self,action:#selector(buttonSelectCompanyProduct),for:.touchUpInside)
            cell.buttonSelectProduct.tag = indexPath.row
            
            return cell
        }
    }
    
    @objc func buttonSelectProduct(sender:UIButton) -> Void
    {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllMyProductListViewController") as! AllMyProductListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchView = "AddProduct"
        nextViewController.selectIndex = sender.tag
        self.navigationController?.present(nextViewController, animated: true, completion: nil)
    }
    
    @objc func buttonSelectCompanyProduct(sender:UIButton) -> Void
    {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Comercial", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AllMyProductListViewController") as! AllMyProductListViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        nextViewController.matchView = "AddProductCompany"
        nextViewController.selectIndex = sender.tag
        self.navigationController?.present(nextViewController, animated: true, completion: nil)
    }
    
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == collView1
        {
           return CGSize(width: 195, height: 675.0)
        }
        else
        {
            return CGSize(width: 195, height: 455.0)
        }
    }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
  {
   
    
       
   }
    
    
    
   
}
