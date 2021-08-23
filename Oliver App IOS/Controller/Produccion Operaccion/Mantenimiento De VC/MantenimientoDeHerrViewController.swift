//
//  MantenimientoDeHerrViewController.swift
//  Oliver App IOS
//
//  Created by apple on 17/02/21.
//

import UIKit
import JGProgressHUD
import Firebase
class MantenimientoDeHerrViewController: UIViewController{
    var companyDetailDict = DataSnapshot()
    var companyId = String()

    @IBOutlet weak var tbl: UITableView!
    var array1 = Array<Any>()
    var array2 = Array<Any>()
    var array3 = Array<Any>()
    var array4 = Array<Any>()
    var array5 = Array<Any>()
    var array6 = Array<Any>()
    var array7 = Array<Any>()
    var array8 = Array<Any>()
    var array9 = Array<Any>()
    var array10 = Array<Any>()
    var array11 = Array<Any>()
    var array12 = Array<Any>()
    var array = Array<Any>()
    let monthArray = ["ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"]
    override func viewDidLoad() {
        super.viewDidLoad()
        companyId = companyDetailDict.key
        tbl.register(UINib(nibName: "MantimientoDeTableViewCell", bundle: nil), forCellReuseIdentifier: "MantimientoDeTableViewCell")
        getProductList()
    }
    func getProductList() -> Void {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let userRef = Database.database().reference().child("My Companies/\(companyId)").child("Machinery Maintenance")
        userRef.observe(.value) { [self] (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                hud.dismiss()
                self.array1.removeAll()
                self.array2.removeAll()
                self.array3.removeAll()
                self.array4.removeAll()
                self.array5.removeAll()
                self.array6.removeAll()
                self.array7.removeAll()
                self.array8.removeAll()
                self.array9.removeAll()
                self.array10.removeAll()
                self.array11.removeAll()
                self.array12.removeAll()
                if array.count > 0
                {
                    for index in 0 ..< array.count {
                    let dict = array[index] as? DataSnapshot
                    let strMonth = dict?.childSnapshot(forPath: "month").value as? String ?? ""
                    if Int(strMonth) == 1 {
                        self.array1.append(array[index])
                    } else if Int(strMonth) == 2 {
                        self.array2.append(array[index])
                    } else if Int(strMonth) == 3 {
                        self.array3.append(array[index])
                    } else if Int(strMonth) == 4 {
                        self.array4.append(array[index])
                    } else if Int(strMonth) == 5 {
                        self.array5.append(array[index])
                    } else if Int(strMonth) == 6 {
                        self.array6.append(array[index])
                    } else if Int(strMonth) == 7 {
                        self.array7.append(array[index])
                    } else if Int(strMonth) == 8 {
                        self.array8.append(array[index])
                    } else if Int(strMonth) == 9 {
                        self.array9.append(array[index])
                    } else if Int(strMonth) == 10 {
                        self.array10.append(array[index])
                    } else if Int(strMonth) == 11 {
                        self.array11.append(array[index])
                    } else if Int(strMonth) == 12 {
                        self.array12.append(array[index])
                    }
                  }
                }
                self.tbl.reloadData()
            }
            else
            {
                hud.dismiss()
            }
        }
    }
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func buttonAddminto(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "ProductionOperation", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddMantenimientoDeHerrVC") as! AddMantenimientoDeHerrVC
        nextViewController.companyDetailDict = companyDetailDict
        nextViewController.modalPresentationStyle = .overFullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
   
    
    
}
//MARK:- TableView Methods
extension MantenimientoDeHerrViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
          return array1.count
        }
        if section == 1
        {
          return array2.count
        }
        if section == 2
        {
         return array3.count
        }
        if section == 3
        {
          return array4.count
        }
        if section == 4
        {
           return array5.count
        }
        if section == 5
        {
           return array6.count
        }
        if section == 6
        {
           return array7.count
        }
        if section == 7
        {
            return array8.count
        }
        if section == 8
        {
            return array9.count
        }
        if section == 9
        {
            return array10.count
        }
        if section == 10
        {
            return array11.count
        }
        return array12.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  indexPath.section == 0
        {
          array = array1
        }
        if indexPath.section == 1
        {
          array = array2
        }
        if indexPath.section == 2
        {
         array = array3
        }
        if indexPath.section == 3
        {
          array = array4
        }
        if indexPath.section == 4
        {
           array = array5
        }
        if indexPath.section == 5
        {
           array = array6
        }
        if indexPath.section == 6
        {
           array = array7
        }
        if indexPath.section == 7
        {
            array = array8
        }
        if indexPath.section == 8
        {
            array = array9
        }
        if indexPath.section == 9
        {
            array = array10
        }
        if indexPath.section == 10
        {
            array = array11
        }
        if indexPath.section == 11 {
            array = array12
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MantimientoDeTableViewCell", for: indexPath) as! MantimientoDeTableViewCell
        cell.selectionStyle = .none
        let obj = self.array[indexPath.row] as! DataSnapshot
        cell.lbl1.text = "\(obj.childSnapshot(forPath: "year").value as? String ?? "")" + "\(obj.childSnapshot(forPath: "month").value as? String ?? "")" + "\(obj.childSnapshot(forPath: "day").value as? String ?? "")"
        cell.lbl2.text = obj.childSnapshot(forPath: "concept").value as? String ?? ""
        cell.lbl3.text = obj.childSnapshot(forPath: "asset").value as? String ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        view.backgroundColor = #colorLiteral(red: 0.9468657374, green: 0.9486127496, blue: 1, alpha: 1)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        lbl.text = monthArray[section]
        lbl.textAlignment = .center
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
