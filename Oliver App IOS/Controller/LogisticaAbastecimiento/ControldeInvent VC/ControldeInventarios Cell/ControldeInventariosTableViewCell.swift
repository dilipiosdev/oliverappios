//
//  NegociosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit

class ControldeInventariosTableViewCell: UITableViewCell {
     
    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
