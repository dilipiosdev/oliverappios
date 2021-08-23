//
//  SendEmailViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 01/02/21.
//

import UIKit
import MessageUI
import Firebase
class SendEmailViewController: UIViewController,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var subViewScreenShot: UIView!
  
    var companyDetailDict = DataSnapshot()
    var customerDetailDict = DataSnapshot()
    var pointStr = String()
    var discountStr = String()

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var buttonDiscount: UIButton!
    @IBOutlet weak var company_social_reason: UILabel!
    @IBOutlet weak var lblBillAmount: UILabel!
    @IBOutlet weak var lblExpairDate: UILabel!
    @IBOutlet weak var imgCompany: UIImageView!
    
    let calendar = Calendar.current
    let date = Date()
    var day = Int()
    var month = Int()
    var year = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setValue()
        }
      
    }
    
    func setValue() -> Void {
       // companyName.text = String(format: "%@", companyDetailDict.childSnapshot(forPath: "company_name").value as? String ?? "")
        company_social_reason.text = String(format: "%@", companyDetailDict.childSnapshot(forPath: "company_social_reason").value as? String ?? "")
        
        let companyImage1 = companyDetailDict.childSnapshot(forPath: "company_image").value as? String ?? ""
        let image:UIImage = UIImage(named: "back")!
        let url = NSURL(string: companyImage1)
        imgCompany.af.setImage(withURL: url! as URL, placeholderImage: image)
        imgCompany.layer.cornerRadius = imgCompany.frame.size.width/2
        lblBillAmount.text =  String(format: "$ %@", customerDetailDict.childSnapshot(forPath: "bill_amount").value as? String ?? "0.00")
        
        lblExpairDate.text = String(format: "%@-%@-%@", customerDetailDict.childSnapshot(forPath: "expiration_day").value as? String ?? "0",customerDetailDict.childSnapshot(forPath: "expiration_month").value as? String ?? "0",customerDetailDict.childSnapshot(forPath: "expiration_year").value as? String ?? "0")
        
     
        lblTitle.text = String(format: "Hola %@, te recordamos que tienes un pago pendiente VENCIDO. Porfavor te animamos a que puedas acercarte a regularizarlo para que sigamos atendiéndote y dándote el mejor servicio como siempre. ¡Te esperamos!", customerDetailDict.childSnapshot(forPath: "customer_name").value as? String ?? "")
        
        
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let timeStrSave = String(format: "%d-%d-%d",components.day!,components.month!,components.year!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let currentDate = dateFormatter.date(from: timeStrSave)
        
        let yearStr = customerDetailDict.childSnapshot(forPath: "expiration_year").value as? String ?? ""
        let monthStr = customerDetailDict.childSnapshot(forPath: "expiration_month").value as? String ?? ""
        let dayStr = customerDetailDict.childSnapshot(forPath: "expiration_day").value as? String ?? ""
        let dateStr = String(format: "%@-%@-%@", dayStr,monthStr,yearStr)
        let expairDate = dateFormatter.date(from: dateStr)
        
        let component1 = self.calendar.dateComponents([.day], from:expairDate! , to: currentDate!)
        
        
        let discountStr = String(format: "VENCIDO HACE %d DÍAS", component1.day ?? 0)
        buttonDiscount.setTitle(discountStr, for: .normal)
        callGmailDelegate()
    }
    
    func callGmailDelegate() -> Void {
      
       guard let image = getScreenshot() else { return  }
         if MFMailComposeViewController.canSendMail() {
           let mail = MFMailComposeViewController()
           mail.mailComposeDelegate = self;
           mail.setToRecipients(["oliverpfasce@gmail.com"])
          
          //"oliverpfasce@gmail.com"
           mail.setSubject("Oliver")
           mail.setMessageBody("Oliver", isHTML: false)
           let imageData: NSData = image.pngData()! as NSData
           mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
          self.present(mail, animated: true, completion: nil)
      }
  }
 
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(subViewScreenShot.frame.size, true, 0.0)
        if let context = UIGraphicsGetCurrentContext() { subViewScreenShot.layer.render(in: context) }
        let screenshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot
    }


}
