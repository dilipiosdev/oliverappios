//
//  SendPointsViewController.swift
//  Oliver App IOS
//
//  Created by apple on 03/02/21.
//

import UIKit
import MessageUI
import Firebase
protocol ProtocolSendPointDelegate: class {
    func popSendPointViewMethod()
}

class SendPointsViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var subViewScreenShot: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companySocialReason: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var customerPoints: UILabel!
    var companyDetailDict = DataSnapshot()
    var customerDetailDict = DataSnapshot()
    var pointStr = String()
    var discountStr = String()

    @IBOutlet weak var lblBottomTitle: UILabel!
    @IBOutlet weak var lblPointTitle: UILabel!
    weak var delegateSendPoint: ProtocolSendPointDelegate?

       
    override func viewDidLoad() {
      super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.setValue()
        }
        
        
    }
    
    func setValue() -> Void {
        companyName.text = String(format: "%@", companyDetailDict.childSnapshot(forPath: "company_name").value as? String ?? "")
        companySocialReason.text = String(format: "%@", companyDetailDict.childSnapshot(forPath: "company_social_reason").value as? String ?? "")
        
        let companyImage1 = companyDetailDict.childSnapshot(forPath: "company_image").value as? String ?? ""
        let image:UIImage = UIImage(named: "back")!
        let url = NSURL(string: companyImage1)
        companyImage.af.setImage(withURL: url! as URL, placeholderImage: image)
        companyImage.layer.cornerRadius = 30
        lblPointTitle.text = String(format: "%@ tus puntos acumulados al día de hoy son:",customerDetailDict.childSnapshot(forPath: "customer_name").value as? String ?? "")
        customerPoints.text = String(format: "%@ PUNTOS", pointStr)
        
        lblBottomTitle.text = String(format: "Hola %@, te escribimos de nombre del negocio, para informarte que haz acumulado \"%@ PUNTOS\" que te dan derecho a un %@%@ en tu próxima compra. Muéstranos el mensaje cuando nos visites nuevamente para darte el descuento o regalo sorpresa. Te esperamos !!!", customerDetailDict.childSnapshot(forPath: "customer_name").value as? String ?? "",pointStr,discountStr,"%")
        
        self.callGmailDelegate()
                    
    }
    
      func callGmailDelegate() -> Void {
        let emailStr = customerDetailDict.childSnapshot(forPath: "customer_email").value as? String ?? ""
         guard let image = getScreenshot() else { return  }
           if MFMailComposeViewController.canSendMail() {
             let mail = MFMailComposeViewController()
             mail.mailComposeDelegate = self;
             mail.setToRecipients([emailStr])
            
            //"oliverpfasce@gmail.com"
             mail.setSubject("Oliver")
             mail.setMessageBody("Oliver", isHTML: false)
             let imageData: NSData = image.pngData()! as NSData
             mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
            self.present(mail, animated: true, completion: nil)
        }
    }
    
    
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
       {
        controller.dismiss(animated: true, completion: {
            self.delegateSendPoint?.popSendPointViewMethod()

        })

       }
    
       
       func getScreenshot() -> UIImage? {
           UIGraphicsBeginImageContextWithOptions(subViewScreenShot.frame.size, true, 0.0)
           if let context = UIGraphicsGetCurrentContext() { subViewScreenShot.layer.render(in: context) }
           let screenshot: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return screenshot
       }
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: {
           // self.delegateSendPoint?.popSendPointViewMethod()

        })
    }
    

}
