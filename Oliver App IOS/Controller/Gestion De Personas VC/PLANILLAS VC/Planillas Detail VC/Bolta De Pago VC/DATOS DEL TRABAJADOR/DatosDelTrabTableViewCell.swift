//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

class DatosDelTrabTableViewCell: UITableViewCell {
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var jobProfileNameSurnameLbl: UILabel!
    @IBOutlet var documentNumberLbl: UILabel!
    @IBOutlet var jobProfileJobNameLbl: UILabel!
    @IBOutlet var beginWorkingDMYLbl: UILabel!
    @IBOutlet var jobProfileLbl: UILabel!
    @IBOutlet var jobProfileAreaLbl: UILabel!
    
    
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
    
    @IBAction func workerDataEditBtnTapped(_ sender: Any) {
        
        
    }
    
    
}
