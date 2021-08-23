//
//  HerramientasVideoTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 16/12/20.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    @IBOutlet weak var subView: UIView!
 
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    
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


