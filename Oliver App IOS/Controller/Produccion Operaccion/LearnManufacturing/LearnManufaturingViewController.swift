//
//  LearnManufaturingViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 05/02/21.
//

import UIKit

class LearnManufaturingViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
 @IBOutlet weak var tbl: UITableView!

 override func viewDidLoad() {
     super.viewDidLoad()

tbl.register(UINib(nibName: "LearnManufacturingTableViewCell", bundle: nil), forCellReuseIdentifier: "LearnManufacturingTableViewCell")
    
 }
 
 @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 5
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "LearnManufacturingTableViewCell", for: indexPath) as! LearnManufacturingTableViewCell
     return cell
     
 }

}
