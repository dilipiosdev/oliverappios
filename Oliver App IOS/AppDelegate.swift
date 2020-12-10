//
//  AppDelegate.swift
//  Oliver App IOS
//
//  Created by Meena on 05/11/20.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
let appDelegate = UIApplication.shared.delegate as! AppDelegate

//@main
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate{


    var diviceToken = String()
var matchView = String()
var userID = String()
var phoneNumber = String()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        self.window = UIWindow(frame: UIScreen.main.bounds)

        if #available(iOS 10.0, *) {
               // For iOS 10 display notification (sent via APNS)
               UNUserNotificationCenter.current().delegate = self
            
               let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
               UNUserNotificationCenter.current().requestAuthorization(
                   options: authOptions,
                   completionHandler: {_, _ in })
                 application.registerForRemoteNotifications()
               // For iOS 10 data message (sent via FCM

           } else {
               let settings: UIUserNotificationSettings =
                   UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
               application.registerUserNotificationSettings(settings)
           }
        
        
        
        let userFireBaseID = UserDefaults.standard.string(forKey: "UserFireBaseID")
      
        appDelegate.phoneNumber = UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""
       
        
        if(userFireBaseID != nil)
        {
            appDelegate.userID = userFireBaseID ?? ""
            let userID = String(format: "Users/%@", userFireBaseID!)
            let userRef = Database.database().reference().child(userID)
            userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any]
            {

                if((dict["pin"] as? String ?? "").count > 0 && self.appDelegate.matchView != "Register" && dict["user_is_enabled"] as? Bool ?? false == true)
                     {
                         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginWithPinViewController") as! LoginWithPinViewController
                         let obj = UINavigationController.init(rootViewController: nextViewController)
                         self.window?.rootViewController = obj
                         self.window?.makeKeyAndVisible()
                     }
                     else
                     {
                         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                         nextViewController.userID = (userFireBaseID)!
                         let obj = UINavigationController.init(rootViewController: nextViewController)
                         self.window?.rootViewController = obj
                         self.window?.makeKeyAndVisible()
                     }
            }
            else
            {
                 let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                 let obj = UINavigationController.init(rootViewController: nextViewController)
                 self.window?.rootViewController = obj
                 self.window?.makeKeyAndVisible()
              }
            }
        }
        else
        {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let inititalViewContoller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
           let obj = UINavigationController.init(rootViewController: inititalViewContoller)
           window?.rootViewController = obj
           window?.makeKeyAndVisible()
        }

        return true
    }
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    // MARK: UISceneSession Lifecycle

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
        print("DEVICE TOKEN = \(deviceToken)")
        var deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
        deviceTokenString = deviceTokenString.replacingOccurrences(of: ">", with: "")
        deviceTokenString = deviceTokenString.replacingOccurrences(of: " ", with: "")
        deviceTokenString = deviceTokenString.replacingOccurrences(of: "<", with: "")
        diviceToken = deviceTokenString
    }
    
    
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

