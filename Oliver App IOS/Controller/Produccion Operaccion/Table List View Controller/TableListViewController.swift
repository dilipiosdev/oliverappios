//
//  CalendarViewController.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 13/03/21.
//

import UIKit

protocol TableListDelegate: class {
    func callTableViewList(match: String, value: String)
}

class TableListViewController: UIViewController {
    var commonArray = Array<Any>()
   
    var matchTable = String()
    var localArray = Array<Any>()
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tbl: UITableView!
    weak var delegateTableList: TableListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Common Arrray...\(self.commonArray)")
        tbl.register(UINib(nibName: "RegisterTableViewCell", bundle: nil), forCellReuseIdentifier:  "RegisterTableViewCell")
        txtSearch.text = ""
        localArray = self.commonArray
        tbl.reloadData()

    }
    
    @IBAction func txtSearch(_ sender: Any) {
            self.commonArray.removeAll()
            if(txtSearch.text!.count > 0)
            {
             
                self.commonArray.append(contentsOf: localArray.filter { ($0 as! String).uppercased().contains(txtSearch.text!.uppercased())
               })
            }
            else
            {
                self.commonArray = localArray
            }
        tbl.reloadData()
   }
}

extension TableListViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.commonArray.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RegisterTableViewCell = self.tbl.dequeueReusableCell(withIdentifier: "RegisterTableViewCell") as! RegisterTableViewCell
        cell.selectionStyle = .none
        cell.subViewSearch.layer.cornerRadius = 5
        cell.subViewSearch.clipsToBounds = true
        
        cell.lblText.text = String(format: "%@", self.commonArray[indexPath.row] as! String)
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        delegateTableList?.callTableViewList(match: self.matchTable, value:  self.commonArray[indexPath.row] as? String ?? "")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*******************************Search *********************************/
    
  
  }




