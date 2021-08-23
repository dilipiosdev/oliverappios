//
//  HerramientasVideoTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 16/12/20.
//

import UIKit

class CosteoTableViewCell: UITableViewCell {
    @IBOutlet weak var subView: UIView!
  
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var subViewSetting: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subView.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


