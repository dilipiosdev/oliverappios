//
//  CapacidadoViewController.swift
//  Oliver App IOS
//
//  Created by apple on 05/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class CapacidadoViewController:  UIViewController {
    var companyDetailDict = DataSnapshot()
    var companyId = String()
    var purchasedOrderArray = Array<Any>()
    @IBOutlet weak var tableView : UITableView!
    
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
       tableView.register(UINib(nibName: "CapacidadoTableViewCell", bundle: nil), forCellReuseIdentifier:  "CapacidadoTableViewCell")
        companyId = companyDetailDict.key
        getProductList()
    }
    
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Production Lines")
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.purchasedOrderArray = array
                self.tableView.reloadData()
                hud.dismiss()

            }
            else
            {
                hud.dismiss()
            }
        }
    }
    
    @IBAction func registerNuasBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCapacidadoViewController") as! AddCapacidadoViewController
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK:- TableView Methods
extension CapacidadoViewController : UITableViewDataSource,UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasedOrderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CapacidadoTableViewCell", for: indexPath) as! CapacidadoTableViewCell
        cell.selectionStyle = .none
        let obj = self.purchasedOrderArray[indexPath.row] as! DataSnapshot
        cell.lblTitle.text = obj.childSnapshot(forPath: "production_line_name").value as? String ?? ""
        cell.lbl1.text = "Capacidad Teorica Maxima \(obj.childSnapshot(forPath: "production_theoretical_capacity").value as? String ?? "")"
        cell.lbl2.text = "Horas hombre necesarias: \(obj.childSnapshot(forPath: "production_man_time").value as? String ?? "") horas mensuales"
       cell.lbl3.text = "Personas:  \(obj.childSnapshot(forPath: "production_man_time").value as? String ?? "")"
        var value1 = Int(obj.childSnapshot(forPath: "production_man_time").value as? String ?? "0")
        value1 = Int((value1 ?? 0) / 192)
        cell.lbl4.text = "Personas: \(value1 ?? 0)"
        let valueX = Int(obj.childSnapshot(forPath: "production_real_production").value as? String ?? "0") ?? 0
        let valueY = Int(obj.childSnapshot(forPath: "production_theoretical_capacity").value as? String ?? "0") ?? 0
        let value2:Double = Double((valueX * 100) / valueY)
        cell.lbl5.text = "Capacidad Utilizada: \(value2) %"

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
 }
