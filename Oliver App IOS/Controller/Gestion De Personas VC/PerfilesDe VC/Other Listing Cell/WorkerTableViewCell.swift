//
//  NegociosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit
protocol SettingButtonProtocol: class {
    func settingButtonTapped(indexPath: IndexPath)
}

class WorkerTableViewCell: UITableViewCell {
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var jobProfileTitleLbl: UILabel!
    @IBOutlet var jobNameLbl: UILabel!
    @IBOutlet var jobAreaLbl: UILabel!
    var delegate : SettingButtonProtocol?
    var indexPath: IndexPath!

    
     
    @IBOutlet var totalComutationLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        subViewbg.layer.cornerRadius = 5
        subViewbg.clipsToBounds = true
        
        subViewbg.layer.masksToBounds = false
        subViewbg.layer.shadowColor = UIColor.lightGray.cgColor
        subViewbg.backgroundColor = UIColor.white
        subViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        subViewbg.layer.shadowOpacity = 0.5
        
        
        // Initialization code
    }
    
    @IBAction func settingBtnTapped(_ sender: Any) {
        self.delegate?.settingButtonTapped(indexPath: self.indexPath)
           
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
