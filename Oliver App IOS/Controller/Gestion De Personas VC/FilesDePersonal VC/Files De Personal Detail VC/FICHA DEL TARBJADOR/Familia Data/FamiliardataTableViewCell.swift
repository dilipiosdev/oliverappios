//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

class FamiliardataTableViewCell: UITableViewCell {
    
       @IBOutlet var subViewbg: UIView!
       @IBOutlet var familiarTitleLbl: UILabel!
       @IBOutlet var editBtn: UIButton!
       @IBOutlet var familiarNameLbl: UILabel!
       @IBOutlet var familiarTypeLbl: UILabel!
       @IBOutlet var familiarDOBLbl: UILabel!
       @IBOutlet var familiarCivilLbl: UILabel!
       @IBOutlet var familiarDocNoLbl: UILabel!
       var familiarDataArray = Array<Any>()
   
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
               subViewbg.layer.cornerRadius = 5
               subViewbg.clipsToBounds = true
               subViewbg.layer.masksToBounds = false
               subViewbg.layer.shadowColor = UIColor.lightGray.cgColor
               subViewbg.backgroundColor = UIColor.white
               subViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
               subViewbg.layer.shadowOpacity = 0.5

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func familiarEditBtnTapped(_ sender: Any) {
          
          
    }

    }
    

