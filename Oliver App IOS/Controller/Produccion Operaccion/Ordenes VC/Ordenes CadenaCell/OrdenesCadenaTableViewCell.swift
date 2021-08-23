//
//  HerramientasVideoTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 16/12/20.
//

import UIKit

class OrdenesCadenaTableViewCell: UITableViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblText1: UILabel!
    @IBOutlet weak var lblText2: UILabel!
    @IBOutlet weak var lblText3: UILabel!
    @IBOutlet weak var lblText4: UILabel!

    @IBOutlet weak var buttonSetting: UIButton!
    @IBOutlet weak var subviewButton: UIView!
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


