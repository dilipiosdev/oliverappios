//
//  ProyeccionViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 06/02/21.
//

import UIKit
import Firebase
import JGProgressHUD
import SwiftCharts

class ProyeccionViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    
    @IBOutlet weak var m1: UITextField!
    @IBOutlet weak var m2: UITextField!
    @IBOutlet weak var m3: UITextField!
    @IBOutlet weak var m4: UITextField!
    @IBOutlet weak var m5: UITextField!
    @IBOutlet weak var m6: UITextField!
    @IBOutlet weak var m7: UITextField!
    @IBOutlet weak var m8: UITextField!
    @IBOutlet weak var m9: UITextField!
    @IBOutlet weak var m10: UITextField!
    @IBOutlet weak var m11: UITextField!
    @IBOutlet weak var m12: UITextField!
    
    
    @IBOutlet weak var mm1: UITextField!
    @IBOutlet weak var mm2: UITextField!
    @IBOutlet weak var mm3: UITextField!
    @IBOutlet weak var mm4: UITextField!
    @IBOutlet weak var mm5: UITextField!
    @IBOutlet weak var mm6: UITextField!
    @IBOutlet weak var mm7: UITextField!
    @IBOutlet weak var mm8: UITextField!
    @IBOutlet weak var mm9: UITextField!
    @IBOutlet weak var mm10: UITextField!
    @IBOutlet weak var mm11: UITextField!
    @IBOutlet weak var mm12: UITextField!
    
    var mmm1:Double = Double()
    var mmm2:Double = Double()
    var mmm3:Double = Double()
    var mmm4:Double = Double()
    var mmm5:Double = Double()
    var mmm6:Double = Double()
    var mmm7:Double = Double()
    var mmm8:Double = Double()
    var mmm9:Double = Double()
    var mmm10:Double = Double()
    var mmm11:Double = Double()
    var mmm12:Double = Double()

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
    var chartArray = [Int]()
    var chartArray1 = [Int]()

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    
    @IBOutlet weak var p1: UILabel!
    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p3: UILabel!
    @IBOutlet weak var p4: UILabel!
    @IBOutlet weak var p5: UILabel!
    @IBOutlet weak var p6: UILabel!
    @IBOutlet weak var p7: UILabel!
    @IBOutlet weak var p8: UILabel!
    @IBOutlet weak var p9: UILabel!
    @IBOutlet weak var p10: UILabel!
    @IBOutlet weak var p11: UILabel!
    @IBOutlet weak var p12: UILabel!

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var chartView1: LineChart!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
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
        getProductList()
        
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
       
    }
  
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                }
                
             
                
                self.m1.text = String(format: "%.2f", self.janValue)
                self.m2.text = String(format: "%.2f", self.febValue)
                self.m3.text = String(format: "%.2f", self.marValue)
                self.m4.text = String(format: "%.2f", self.aprilValue)
                self.m5.text = String(format: "%.2f", self.mayValue)
                self.m6.text = String(format: "%.2f", self.junValue)
                self.m7.text = String(format: "%.2f", self.julyValue)
                self.m8.text = String(format: "%.2f", self.augValue)
                self.m9.text = String(format: "%.2f", self.sepValue)
                self.m10.text = String(format: "%.2f", self.octValue)
                self.m11.text = String(format: "%.2f", self.novValue)
                self.m12.text = String(format: "%.2f", self.decValue)
                self.methodSetValue()
                self.addValueInArray()
                hud.dismiss()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    @IBAction func chengeValue(_ textField: UITextField) {
        if textField == m1 {
            self.janValue = Double(m1.text ?? "0") ?? 0
        } else if textField == m2 {
            self.febValue = Double(m2.text ?? "0") ?? 0
        } else if textField == m3 {
            self.marValue = Double(m3.text ?? "0") ?? 0
        } else if textField == m4 {
            self.aprilValue = Double(m4.text ?? "0") ?? 0
        } else if textField == m5 {
            self.mayValue = Double(m5.text ?? "0") ?? 0
        } else if textField == m6 {
            self.junValue = Double(m6.text ?? "0") ?? 0
        } else if textField == m7 {
            self.julyValue = Double(m7.text ?? "0") ?? 0
        } else if textField == m8 {
            self.augValue = Double(m8.text ?? "0") ?? 0
        } else if textField == m9 {
            self.sepValue = Double(m9.text ?? "0") ?? 0
        } else if textField == m10 {
            self.octValue = Double(m10.text ?? "0") ?? 0
        } else if textField == m11 {
            self.novValue = Double(m11.text ?? "0") ?? 0
        } else if textField == m12 {
            self.decValue = Double(m12.text ?? "0") ?? 0
        }
        methodSetValue()
        addValueInArray()
    }
    
    
    func addValueInArray() -> Void {
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
        
        self.chartArray1.removeAll()
        self.chartArray1.append(Int(mmm1))
        self.chartArray1.append(Int(mmm2))
        self.chartArray1.append(Int(mmm3))
        self.chartArray1.append(Int(mmm4))
        self.chartArray1.append(Int(mmm5))
        self.chartArray1.append(Int(mmm6))
        self.chartArray1.append(Int(mmm7))
        self.chartArray1.append(Int(mmm8))
        self.chartArray1.append(Int(mmm9))
        self.chartArray1.append(Int(mmm10))
        self.chartArray1.append(Int(mmm11))
        self.chartArray1.append(Int(mmm12))
        self.getChart()
    }
    
   
    
    func methodSetValue() -> Void {
        let sumofX = 78.00
        let sumofY = self.janValue + self.febValue + self.marValue + self.aprilValue + self.mayValue + self.junValue + self.julyValue + self.augValue + self.sepValue + self.octValue + self.novValue + self.decValue
        

         let sumofXY = (self.janValue * 1) + (self.febValue * 2) + (self.marValue * 3) + (self.aprilValue * 4) + (self.mayValue * 5) + (self.junValue * 6) + (self.julyValue * 7) + (self.augValue * 8) + (self.sepValue * 9) + (self.octValue * 10) + (self.novValue * 11) + (self.decValue * 12)
        
        let sumofXX = 650.00
        
        let value1 =  ((12 * sumofXY) -  (sumofX * sumofY))
        let value2 =  ((12 * sumofXX) - (sumofXX))

        var a:Double = Double()
        var b:Double = Double()
        if value2 > 0 {
            b = value1 / value2
            b = Double(String(format: "%.2f", b)) ?? 0
            
            a = (1273 - (b * sumofX ))  / 12
            a = Double(String(format: "%.2f", a)) ?? 0
            
        }
        
        
      //  let sumofYY = self.janValue * self.janValue + self.febValue * self.febValue + self.marValue * self.marValue + self.aprilValue * self.aprilValue + self.mayValue * self.mayValue + self.junValue * self.junValue + self.julyValue * self.julyValue + self.augValue * self.augValue + self.sepValue * self.sepValue + self.octValue * self.octValue + self.novValue * self.novValue + self.decValue * self.decValue
        
       

        
  
        
        
         mmm1 = a + (b * self.janValue) / 12
         mmm2 = a + (b * self.febValue) / 12
         mmm3 = a + (b * self.marValue) / 12
         mmm4 = a + (b * self.aprilValue) / 12
         mmm5 = a + (b * self.mayValue) / 12
         mmm6 = a + (b * self.junValue) / 12
         mmm7 = a + (b * self.julyValue) / 12
         mmm8 = a + (b * self.augValue) / 12
         mmm9 = a + (b * self.sepValue) / 12
         mmm10 = a + (b * self.octValue) / 12
         mmm11 = a + (b * self.novValue) / 12
         mmm12 = a + (b * self.decValue) / 12
        
        
        
     

        self.mm1.text = String(format: "%.2f", mmm1)
        self.mm2.text = String(format: "%.2f", mmm2)
        self.mm3.text = String(format: "%.2f", mmm3)
        self.mm4.text = String(format: "%.2f", mmm4)
        self.mm5.text = String(format: "%.2f", mmm5)
        self.mm6.text = String(format: "%.2f", mmm6)
        self.mm7.text = String(format: "%.2f", mmm7)
        self.mm8.text = String(format: "%.2f", mmm8)
        self.mm9.text = String(format: "%.2f", mmm9)
        self.mm10.text = String(format: "%.2f", mmm10)
        self.mm11.text = String(format: "%.2f", mmm11)
        self.mm12.text = String(format: "%.2f", mmm12)
        
        self.p1.text = String(format: "%.2f%@", ((Double(mm1.text ?? "0") ?? 0) - (Double(m1.text ?? "0") ?? 0)),"%")
        self.p2.text = String(format: "%.2f%@", ((Double(mm2.text ?? "0") ?? 0) - (Double(m2.text ?? "0") ?? 0)),"%")
        self.p3.text = String(format: "%.2f%@", ((Double(mm3.text ?? "0") ?? 0) - (Double(m3.text ?? "0") ?? 0)),"%")
        self.p4.text = String(format: "%.2f%@", ((Double(mm4.text ?? "0") ?? 0) - (Double(m4.text ?? "0") ?? 0)),"%")
        self.p5.text = String(format: "%.2f%@", ((Double(mm5.text ?? "0") ?? 0) - (Double(m5.text ?? "0") ?? 0)),"%")
        self.p6.text = String(format: "%.2f%@", ((Double(mm6.text ?? "0") ?? 0) - (Double(m6.text ?? "0") ?? 0)),"%")
        self.p7.text = String(format: "%.2f%@", ((Double(mm7.text ?? "0") ?? 0) - (Double(m7.text ?? "0") ?? 0)),"%")
        self.p8.text = String(format: "%.2f%@", ((Double(mm8.text ?? "0") ?? 0) - (Double(m8.text ?? "0") ?? 0)),"%")
        self.p9.text = String(format: "%.2f%@", ((Double(mm9.text ?? "0") ?? 0) - (Double(m9.text ?? "0") ?? 0)),"%")
        self.p10.text = String(format: "%.2f%@", ((Double(mm10.text ?? "0") ?? 0) - (Double(m10.text ?? "0") ?? 0)),"%")
        self.p11.text = String(format: "%.2f%@", ((Double(mm11.text ?? "0") ?? 0) - (Double(m11.text ?? "0") ?? 0)),"%")
        self.p12.text = String(format: "%.2f%@", ((Double(mm12.text ?? "0") ?? 0) - (Double(m12.text ?? "0") ?? 0)),"%")
        
        
        
        if ((Double(mm1.text ?? "0") ?? 0) - (Double(m1.text ?? "0") ?? 0)) < 0 {
            self.p1.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p1.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm2.text ?? "0") ?? 0) - (Double(m2.text ?? "0") ?? 0)) < 0 {
            self.p2.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p2.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm3.text ?? "0") ?? 0) - (Double(m3.text ?? "0") ?? 0)) < 0 {
            self.p3.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p3.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm4.text ?? "0") ?? 0) - (Double(m4.text ?? "0") ?? 0)) < 0 {
            self.p4.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p4.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm5.text ?? "0") ?? 0) - (Double(m5.text ?? "0") ?? 0)) < 0 {
            self.p5.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p5.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm6.text ?? "0") ?? 0) - (Double(m6.text ?? "0") ?? 0)) < 0 {
            self.p6.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p6.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm7.text ?? "0") ?? 0) - (Double(m7.text ?? "0") ?? 0)) < 0 {
            self.p7.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p7.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm8.text ?? "0") ?? 0) - (Double(m8.text ?? "0") ?? 0)) < 0 {
            self.p8.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p8.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm9.text ?? "0") ?? 0) - (Double(m9.text ?? "0") ?? 0)) < 0 {
            self.p9.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p9.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm10.text ?? "0") ?? 0) - (Double(m10.text ?? "0") ?? 0)) < 0 {
            self.p10.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p10.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm11.text ?? "0") ?? 0) - (Double(m11.text ?? "0") ?? 0)) < 0 {
            self.p11.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p11.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        if ((Double(mm12.text ?? "0") ?? 0) - (Double(m12.text ?? "0") ?? 0)) < 0 {
            self.p12.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            self.p12.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }

    }
    
    
    @IBAction func btn1(_ sender: Any) {
        lbl1.isHidden = false
        lbl2.isHidden = true
        lbl3.isHidden = true
        self.scrollToPage(page: Int(0), animated: true)

    }
    @IBAction func btn2(_ sender: Any) {
        lbl1.isHidden = true
        lbl2.isHidden = false
        lbl3.isHidden = true
        self.scrollToPage(page: Int(1), animated: true)

    }
    @IBAction func btn3(_ sender: Any) {
        lbl1.isHidden = true
        lbl2.isHidden = true
        lbl3.isHidden = false
        self.scrollToPage(page: Int(2), animated: true)

    }
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageWidth: CGFloat = scrollView.frame.width
            let current: CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            print(current)
        if current == 0{
            lbl1.isHidden = false
            lbl2.isHidden = true
            lbl3.isHidden = true
        } else  if current == 1{
            lbl1.isHidden = true
            lbl2.isHidden = false
            lbl3.isHidden = true
        } else {
            lbl1.isHidden = true
            lbl2.isHidden = true
            lbl3.isHidden = false
        }
        self.scrollToPage(page: Int(current), animated: true)
    }
    
    
    
    func getChart()  {
        let dataEntries = generateRandomEntries()
        chartView1.dataEntries = dataEntries
        chartView1.isCurved = false
        chartView1.showDots = true
        chartView1.animateDots = true
    }
    private func generateRandomEntries() -> [PointEntry] {
        var result: [PointEntry] = []
        for i in 0..<chartArray.count {
            let value  = Int(chartArray[i])
            result.append(PointEntry(value: value, label: String(format: "%d", i + 1)))
        }
      
        return result
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: chartView1)
            print(position)
        }
    }
    
}
