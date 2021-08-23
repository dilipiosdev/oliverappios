//
//  NegociosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit

class OtherFunctionTableViewCell: UITableViewCell {
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var valueLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
