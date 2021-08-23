//
//  HerramientasVideoTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 16/12/20.
//

import UIKit

class RealTableViewCell: UITableViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var subViewSetting: UIView!
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblText1: UILabel!
    @IBOutlet weak var lblText2: UILabel!

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var buttonSetting: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


