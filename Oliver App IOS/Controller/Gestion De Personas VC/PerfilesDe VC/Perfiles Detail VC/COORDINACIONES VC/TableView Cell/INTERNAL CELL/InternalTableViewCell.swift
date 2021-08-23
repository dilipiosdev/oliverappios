//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

class InternalTableViewCell: UITableViewCell {
       @IBOutlet var subViewbg: UIView!
       @IBOutlet var mainViewbg: UIView!
      @IBOutlet var headerLbl: UILabel!

       @IBOutlet var coordAreaLbl: UILabel!
       @IBOutlet var coordDenominationLbl: UILabel!
       @IBOutlet var coordImmediateBossLbl: UILabel!
      


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
        
        mainViewbg.layer.cornerRadius = 5
        mainViewbg.clipsToBounds = true
        mainViewbg.layer.masksToBounds = false
        mainViewbg.layer.shadowColor = UIColor.lightGray.cgColor
        mainViewbg.backgroundColor = UIColor.white
        mainViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        mainViewbg.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
