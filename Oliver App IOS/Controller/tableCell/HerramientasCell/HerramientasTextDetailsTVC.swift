//
//  HerramientasTextDetailsTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 18/12/20.
//

import UIKit

class HerramientasTextDetailsTVC: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    
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
