//
//  SceneDelegate.swift
//  Oliver App IOS
//
//  Created by Meena on 05/11/20.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        
        let userPin = UserDefaults.standard.string(forKey: "Pin")
        let userFireBaseID = UserDefaults.standard.string(forKey: "UserFireBaseID")

        if(userFireBaseID != nil) && (userPin != nil)
        {
            appDelegate.userID = userFireBaseID!
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let obj = UINavigationController.init(rootViewController: nextViewController)
            self.window?.rootViewController = obj
            self.window?.makeKeyAndVisible()
        }
        
        else if(userFireBaseID == nil || userFireBaseID?.isEmpty == true) && (userPin != nil)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let obj = UINavigationController.init(rootViewController: nextViewController)
            self.window?.rootViewController = obj
            self.window?.makeKeyAndVisible()
        }
        else if(userFireBaseID != nil)
        {
            let userID = String(format: "Users/%@", userFireBaseID!)
            let userRef = Database.database().reference().child(userID)
            userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any]
            {
                 
                    if((dict["pin"] as? String ?? "").count > 0  && dict["user_is_enabled"] as? Bool ?? false == true)
                     {
                         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
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
          guard let windowScene = (scene as? UIWindowScene) else {return}
          window = UIWindow(frame: windowScene.coordinateSpace.bounds)
          window?.windowScene = windowScene
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let inititalViewContoller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
          let obj = UINavigationController.init(rootViewController: inititalViewContoller)
          window?.rootViewController = obj
          window?.makeKeyAndVisible()
        }
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

