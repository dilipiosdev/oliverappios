//
//  DashBoardVentasVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 07/01/21.
//

import UIKit
import Firebase
import JGProgressHUD
class DashBoardVentasVC: UIViewController {

    @IBOutlet weak var tbl1: UITableView!
    @IBOutlet weak var tbl2: UITableView!
    @IBOutlet weak var tbl3: UITableView!
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

    override func viewDidLoad() {
        super.viewDidLoad()
         janValue = 0
         febValue = 0
         marValue = 0
         aprilValue = 0
         mayValue = 0
         junValue = 0
         julyValue = 0
         augValue = 0
         sepValue = 0
         octValue = 0
         novValue = 0
         decValue = 0
        
        tbl1.register(UINib(nibName: "BillTableViewCell", bundle: nil), forCellReuseIdentifier: "BillTableViewCell")
        tbl1.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        
        tbl1.register(UINib(nibName: "ChartTableViewCell", bundle: nil), forCellReuseIdentifier: "ChartTableViewCell")
        
        tbl2.register(UINib(nibName: "BillTableViewCell", bundle: nil), forCellReuseIdentifier: "BillTableViewCell")
        tbl2.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        
        tbl3.register(UINib(nibName: "BillTableViewCell", bundle: nil), forCellReuseIdentifier: "BillTableViewCell")
        tbl3.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        self.monthProductTotle = 0.00
        getProductList()
        getMonthProductList()
        getCustomerByPurchasedList()
    }
    
    func getProductList()  {
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let userRef =
            Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("My Bills")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
               var currentYearKey = String()
               currentYearKey = String(format:"%d",self.calendar.component(.year, from: self.date))

               for item in array {
                let dict = item as! DataSnapshot
                let currentYear = dict.childSnapshot(forPath: "issuing_year").value as? Int ?? 0
                let monthIndex = dict.childSnapshot(forPath: "issuing_month").value as? Int ?? -1
                if((currentYear == Int(currentYearKey)) && (monthIndex > 0))
                {
                    let quintityValueJan = Double(dict.childSnapshot(forPath: "bill_amount").value as? String ?? "0.00") ?? 0.00
                    if(monthIndex == 1)
                    {
                      self.janValue = self.janValue + quintityValueJan
                    }
                    if(monthIndex == 2)
                    {
                      self.febValue = self.febValue + quintityValueJan
                    }
                    if(monthIndex == 3)
                    {
                      self.marValue = self.marValue + quintityValueJan
                    }
                    if(monthIndex == 4)
                    {
                      self.aprilValue = self.aprilValue + quintityValueJan
                    }
                    if(monthIndex == 5)
                    {
                      self.mayValue = self.mayValue + quintityValueJan
                    }
                    if(monthIndex == 6)
                    {
                      self.junValue = self.junValue + quintityValueJan
                    }
                    if(monthIndex == 7)
                    {
                      self.julyValue = self.julyValue + quintityValueJan
                    }
                    if(monthIndex == 8)
                    {
                      self.augValue = self.augValue + quintityValueJan
                    }
                    if(monthIndex == 9)
                    {
                      self.sepValue = self.sepValue + quintityValueJan
                    }
                    if(monthIndex == 10)
                    {
                      self.octValue = self.octValue + quintityValueJan
                    }
                    if(monthIndex == 11)
                    {
                      self.novValue = self.novValue + quintityValueJan
                    }
                    if(monthIndex == 12)
                    {
                      self.decValue = self.decValue + quintityValueJan
                    }
                 }
                    self.chartArray.removeAll()
                
                
                    self.chartArray.append(Int(self.janValue))
                    self.chartArray.append(Int(self.febValue))
                    self.chartArray.append(Int(self.marValue))
                    self.chartArray.append(Int(self.aprilValue))
                    self.chartArray.append(Int(self.mayValue))
                    self.chartArray.append(Int(self.junValue))
                    self.chartArray.append(Int(self.julyValue))
                    self.chartArray.append(Int(self.augValue))
                    self.chartArray.append(Int(self.sepValue))
                    self.chartArray.append(Int(self.octValue))
                    self.chartArray.append(Int(self.novValue))
                    self.chartArray.append(Int(self.decValue))
                    self.tbl1.reloadData()
                }
                hud.dismiss()
            }
            else
            {
                hud.dismiss()
            }
        }
        
        
     
    }
    func getMonthProductList()  {
        self.productByMonthArray.removeAll()
        let userRef =
            Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("My Products")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
           if let array = snapshot.children.allObjects as? Array<Any>
           {
             var quintityKey = String()
             quintityKey = String(format:"%d%dquantity",self.calendar.component(.year, from: self.date),self.calendar.component(.month, from: self.date))
               for item in array {
                 let dict = item as! DataSnapshot
                 let quintityValueMyMonth = dict.childSnapshot(forPath: quintityKey).value as? Double ?? 0.00
                 if(quintityValueMyMonth >= 0.00)
                 {
                    self.productByMonthArray.append(item as! DataSnapshot)
                 }
                 self.monthProductTotle = self.monthProductTotle + quintityValueMyMonth
             }
            self.productByMonthArray = self.productByMonthArray.sorted(by: {$0.childSnapshot(forPath: quintityKey).value as? Double ?? 0.00 > $1.childSnapshot(forPath: quintityKey).value as? Double ?? 0.00})
              self.tbl2.reloadData()
           }
       }
    }

    func getCustomerByPurchasedList()  {
        self.customerByPurchaseArray.removeAll()
        let userRef =
            Database.database().reference().child("My Companies/\(companyDetailDict.key)").child("Customers")
        userRef.observeSingleEvent(of: .value) { (snapshot) in
           if let array = snapshot.children.allObjects as? Array<Any>
           {
               for item in array {
                 let dict = item as! DataSnapshot
                 let quintityValueMyMonth = dict.childSnapshot(forPath: "purchased_total_amount").value as? Double ?? 0.00
                 if(quintityValueMyMonth >= 0.00)
                 {
                    self.customerByPurchaseArray.append(item as! DataSnapshot)
                 }
                 self.purchhasedTotle = self.purchhasedTotle + quintityValueMyMonth
             }
            self.customerByPurchaseArray = self.customerByPurchaseArray.sorted(by: {$0.childSnapshot(forPath: "purchased_total_amount").value as? Double ?? 0.00 > $1.childSnapshot(forPath: "purchased_total_amount").value as? Double ?? 0.00})
              self.tbl3.reloadData()
           }
       }
    }
    

    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonShowBillTapped(_ sender: Any) {
        self.scrollToPage(page: 0, animated: true)
       }
    
    @IBAction func buttonShowProductTapped(_ sender: Any) {
        self.scrollToPage(page: 1, animated: true)

       }
    
    @IBAction func buttonShowCustomerTapped(_ sender: Any) {
        self.scrollToPage(page: 2, animated: true)

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
}

extension DashBoardVentasVC : UITableViewDataSource, UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tbl1)
        {
          return 2
        }
        if(tableView == tbl2)
        {
            if(self.productByMonthArray.count > 10)
            {
                return 10
            }
            return self.productByMonthArray.count
        }
        if(tableView == tbl3)
        {
            if(self.customerByPurchaseArray.count > 10)
            {
                return 10
            }
            return self.customerByPurchaseArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tbl1)
        {
            if(indexPath.row == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BillTableViewCell", for: indexPath) as! BillTableViewCell
                cell.labelHeaderTime.text = String(format:"Año: %d",self.calendar.component(.year, from: self.date))
                cell.labelJan.text = String(format: "S/ %.2f",janValue)
                cell.labelFeb.text = String(format: "S/ %.2f",febValue)
                cell.labelMAr.text = String(format: "S/ %.2f",marValue)
                cell.labelApril.text = String(format: "S/ %.2f",aprilValue)
                cell.labelMay.text = String(format: "S/ %.2f",mayValue)
                cell.labelJun.text = String(format: "S/ %.2f",junValue)
                cell.labelJuly.text = String(format: "S/ %.2f",julyValue)
                cell.labelAug.text = String(format: "S/ %.2f",augValue)
                cell.labelSep.text = String(format: "S/ %.2f",sepValue)
                cell.labelOctober.text = String(format: "S/ %.2f",octValue)
                cell.labelNov.text = String(format: "S/ %.2f",novValue)
                cell.labelDec.text = String(format: "S/ %.2f",decValue)
                cell.selectionStyle = .none
                return cell

            }
            else
            {
                let cell = tbl1.dequeueReusableCell(withIdentifier: "ChartTableViewCell", for: indexPath) as! ChartTableViewCell
                cell.chartArray = chartArray
                cell.getChart()

                return cell
            }
        }
        else if(tableView == tbl2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
            var quintityKey = String()
            quintityKey = String(format:"%d%dquantity",self.calendar.component(.year, from: self.date),self.calendar.component(.month, from: self.date))
            let item = productByMonthArray[indexPath.row]
            cell.lblName.text = String(format: "%@", item.childSnapshot(forPath: "product_name").value as? String ?? "")
            cell.lblPercentage.text =  String(format: "%.2f", ((item.childSnapshot(forPath: quintityKey).value as? Double ?? 0.00) * 100)/monthProductTotle) + " %"
            cell.lblQty.text = String(format: "%.2f", item.childSnapshot(forPath: quintityKey).value as? Double ?? 0.00)
            let url = NSURL(string: String(format: "%@",item.childSnapshot(forPath: "product_image").value as? String ?? ""))
            let image:UIImage = UIImage(named: "back")!
            cell.imgView.af.setImage(withURL: url! as URL, placeholderImage: image)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
            let item = customerByPurchaseArray[indexPath.row]
            cell.lblName.text = String(format: "%@", item.childSnapshot(forPath: "customer_name").value as? String ?? "")
            cell.lblQty.text = String(format: "S/ %.2f", item.childSnapshot(forPath: "purchased_total_amount").value as? Double ?? 0.00)
            cell.lblPercentage.text =  String(format: "%.2f%", ((item.childSnapshot(forPath: "purchased_total_amount").value as? Double ?? 0.00)/purchhasedTotle) * 100) + " %"
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == tbl1)
        {
            if(indexPath.row == 0)
            {
              return 600
            }
             return 300
        } else
        {
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }

    //MARK-: ScrollView Delegate Methods
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageWidth: CGFloat = scrollView.frame.width
            let current: CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            print(current)
        self.scrollToPage(page: Int(current), animated: true)

        
    }
    
    func scrollToPage(page: Int, animated: Bool) {
       
        var frame: CGRect = self.collectionCropPaging.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.collectionCropPaging.scrollRectToVisible(frame, animated: animated)
       
        if page == 0 {
            self.tbl1.reloadData()
        }else if page == 1 {
            self.tbl2.reloadData()
        }
        else if page == 2 {
            self.tbl3.reloadData()
        }
    }
    
}
