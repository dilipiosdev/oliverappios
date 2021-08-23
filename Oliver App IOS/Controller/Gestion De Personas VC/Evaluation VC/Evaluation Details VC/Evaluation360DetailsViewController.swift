//
//  PerfileDetailsViewController.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
import Firebase

class Evaluation360DetailsViewController: UIViewController {
    var pageMenu : CAPSPageMenu?
    var companyDetailDict = DataSnapshot()


    override func viewDidLoad() {
        super.viewDidLoad()

           // MARK: - Scroll menu setup
            
            // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "GestionDePersonas", bundle:nil)
        let controller1 = storyBoard.instantiateViewController(withIdentifier: "GerenteOptionViewController") as! GerenteOptionViewController
            controller1.title = "GERENTE / DUENO"
            controllerArray.append(controller1)
        //controller1.companyDetailDict = companyDetailDict
        
           
            let controller2 = storyBoard.instantiateViewController(withIdentifier: "GerenteOptionViewController") as! GerenteOptionViewController
            controller2.title = "JEFE / LIDER"
            controllerArray.append(controller2)
        
           let controller3 = storyBoard.instantiateViewController(withIdentifier: "GerenteOptionViewController") as! GerenteOptionViewController
            controller3.title = "COMPANERO"
            controllerArray.append(controller3)
        
        
        let controller4 = storyBoard.instantiateViewController(withIdentifier: "GerenteOptionViewController") as! GerenteOptionViewController
                   controller4.title = "RESULTADOS"
                   controllerArray.append(controller4)
               
            
            // Customize menu (Optional)
            let parameters: [CAPSPageMenuOption] = [
                .scrollMenuBackgroundColor(UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .viewBackgroundColor(UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)),
                .selectionIndicatorColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)),
                .bottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
                .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
                .menuHeight(60.0),
                .menuItemWidth(100.0),
                .centerMenuItems(true),
                .addBottomMenuShadow(true),
                .menuShadowColor(UIColor.white),
                .menuShadowRadius(4)
            ]
            
            // Initialize scroll menu
            let rect = CGRect(origin: CGPoint(x: 0,y :100), size: CGSize(width: self.view.frame.width, height: self.view.frame.height + 10))
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: rect, pageMenuOptions: parameters)

            self.addChild(pageMenu!)
            self.view.addSubview(pageMenu!.view)
            pageMenu!.didMove(toParent: self)
        }
    
    @IBAction func buttonBack(_ sender: Any) {
        
            self.navigationController?.popViewController(animated: true)

     }
    // MARK: - Container View Controller
        
        override func shouldAutomaticallyForwardRotationMethods() -> Bool {
            return true
        }
    

}
