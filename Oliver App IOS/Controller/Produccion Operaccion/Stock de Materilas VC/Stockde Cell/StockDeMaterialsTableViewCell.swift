//
//  NegociosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit

class StockDeMaterialsTableViewCell: UITableViewCell {
    @IBOutlet var subViewbg: UIView!
     
    @IBOutlet var buttonSubView: UIView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnGestionar: UIButton!
    @IBOutlet var lblComapanyName: UILabel!
    @IBOutlet var lblDes: UILabel!
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonSubView.layer.addSublayer(GlobleClass.backGrayGroundColor())
        buttonSubView.layer.cornerRadius = 5
        buttonSubView.clipsToBounds = true
        
        
        
        
        subViewbg.layer.cornerRadius = 5
        subViewbg.clipsToBounds = true
        imgView.layer.cornerRadius = 30
        
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
    
}
