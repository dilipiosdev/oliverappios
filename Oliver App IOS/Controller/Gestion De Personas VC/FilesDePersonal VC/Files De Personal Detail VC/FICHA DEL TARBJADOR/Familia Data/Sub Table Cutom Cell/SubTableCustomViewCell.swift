//
//  SubTableCustomViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 18/03/21.
//

import UIKit
import Firebase
protocol FamiliarDataProtocol: class {
    func familiarEditButtonTapped()
}

class SubTableCustomViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var subMenuTable:UITableView?
    var familiarDataArray = Array<Any>()
    var companyDetailDict = DataSnapshot()
    var company_Id = String()
    var worker_Id = String()
    var personalFileArray = Array<Any>()
    var delegate : FamiliarDataProtocol?
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
         setUpTable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpTable()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpTable()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setUpTable() {
        
        self.subMenuTable = UITableView(frame: CGRect.zero, style:UITableView.Style.plain)
        self.addSubview(self.subMenuTable!)
        self.getPersonalFileDateList()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subMenuTable?.frame = CGRect(x: 0.2, y: 0.3, width: self.bounds.size.width-5, height: self.bounds.size.height-5)
        self.subMenuTable?.register(UINib(nibName: "FamiliardataTableViewCell", bundle: nil), forCellReuseIdentifier: "FamiliardataTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.personalFileArray.isEmpty == false {
            return self.familiarDataArray.count
        } else {
        return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamiliardataTableViewCell", for: indexPath) as! FamiliardataTableViewCell
         if self.personalFileArray.isEmpty == false {
        
            if  let obj = self.familiarDataArray[indexPath.row] as? DataSnapshot {
        cell.familiarNameLbl.text =  obj.childSnapshot(forPath: "familiar_name").value as? String ?? ""
        
        cell.familiarTypeLbl.text =  obj.childSnapshot(forPath: "familiar_type").value as? String ?? ""
        
        cell.familiarDOBLbl.text = "Fecha de Nacimiento: \( obj.childSnapshot(forPath: "familiar_bth_day").value as? String ?? "")/\( obj.childSnapshot(forPath: "familiar_bth_month").value as? String ?? "")/\( obj.childSnapshot(forPath: "familiar_bth_year").value as? String ?? "")"
        
        cell.familiarCivilLbl.text = "Estado Civil: \( obj.childSnapshot(forPath: "familiar_bth_civil_state").value as? String ?? "")"
        
        cell.familiarDocNoLbl.text = "N de Documento de Identidad: \( obj.childSnapshot(forPath: "familiar_document_number").value as? String ?? "")"
            }
         } else {
            
                 cell.familiarNameLbl.text = "Sin Información"
                  
                  cell.familiarTypeLbl.text =  "Sin Información"
                  
                  cell.familiarDOBLbl.text = "Fecha de Nacimiento: \("Sin Información")"
                  cell.familiarCivilLbl.text = "Estado Civil: \("Sin Información")"
                  
                  cell.familiarDocNoLbl.text = "N de Documento de Identidad: \("Sin Información")"
            
        }
        
        if indexPath.row == 0 {
            cell.familiarTitleLbl.isHidden = false
            cell.editBtn.isHidden = false
            
        } else {
            cell.familiarTitleLbl.isHidden = true
            cell.editBtn.isHidden = true
        }
        
        cell.editBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 210
    }
    
    //MARK:- Get Worked List
    func getPersonalFileDateList() -> Void {
        if let dict = UserDefaults.standard.value(forKey: "PROFILEDICT") as? [String: String] {
            self.worker_Id = dict["Worker_Id"]!
            self.company_Id = dict["Compnay_Id"]!
        }
        
        let userRef =  Database.database().reference().child("My Companies").child(self.company_Id).child("Job Profile").child(self.worker_Id).child("Personal File")
        //.child("Birth Data")
        
        userRef.observe(.value) { (snapshot) in
            if let array = snapshot.children.allObjects as? Array<Any>
            {
                self.personalFileArray = array
                
                if self.personalFileArray.isEmpty == false {
                               print("There are objects!")
                
                let obj = self.personalFileArray[5] as! DataSnapshot
                if let array1 = obj.children.allObjects as? Array<Any>
                {
                    self.familiarDataArray = array1
                    print("familiarDataArray is \(self.familiarDataArray)")
                }
                
                self.subMenuTable?.delegate = self
                self.subMenuTable?.dataSource = self
                self.subMenuTable?.reloadData()
                } else {
                    self.subMenuTable?.delegate = self
                    self.subMenuTable?.dataSource = self
                    self.subMenuTable?.reloadData()
                }
                
            }
        }
    }
    
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
       self.delegate?.familiarEditButtonTapped()
        
    }
    
}
