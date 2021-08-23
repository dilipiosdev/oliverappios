//
//  ResuenViewController.swift
//  Oliver App IOS
//
//  Created by apple on 04/02/21.
//

import UIKit

class ResuenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CosteoTableViewCell", bundle: nil), forCellReuseIdentifier:  "CosteoTableViewCell")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CosteoTableViewCell", for: indexPath) as! CosteoTableViewCell
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FichasDetailsViewController") as! FichasDetailsViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
}
