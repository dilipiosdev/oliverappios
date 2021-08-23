//
//  NegociosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit

class Section4TableViewCell: UITableViewCell {
    
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var btnMasDetail: UIButton!
    @IBOutlet var specificationLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var pasoLbl: UILabel!
    @IBOutlet var siBtn: UIButton!
    @IBOutlet var nOBtn: UIButton!


    
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func masDetailButtonTapped(_ sender: Any) {
           
    }
    
    @IBAction func siBtnTapped(_ sender: Any) {
        
      }
    
    @IBAction func noBtnTapped(_ sender: Any) {
           
         }
    
}
