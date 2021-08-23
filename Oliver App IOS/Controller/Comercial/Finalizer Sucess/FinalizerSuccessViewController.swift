//
//  FinalizerSuccessViewController.swift
//  Oliver App IOS
//
//  Created by apple on 08/01/21.
//

import UIKit

class FinalizerSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func enVierBtnTapped(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func iRaMissBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
