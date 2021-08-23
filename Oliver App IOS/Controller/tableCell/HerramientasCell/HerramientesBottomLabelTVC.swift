//
//  HerramientesBottomLabelTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 18/12/20.
//

import UIKit

class HerramientesBottomLabelTVC: UITableViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblTxt: UILabel!
    
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
