//
//  TercerizacionViewController.swift
//  Oliver App IOS
//
//  Created by apple on 08/02/21.
//

import UIKit

class TercerizacionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 @IBOutlet weak var tbl: UITableView!

 override func viewDidLoad() {
     super.viewDidLoad()

tbl.register(UINib(nibName: "TercerizacionTableViewCell", bundle: nil), forCellReuseIdentifier: "TercerizacionTableViewCell")
 }
 
 @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 5
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "TercerizacionTableViewCell", for: indexPath) as! TercerizacionTableViewCell
     return cell
     
 }
}
