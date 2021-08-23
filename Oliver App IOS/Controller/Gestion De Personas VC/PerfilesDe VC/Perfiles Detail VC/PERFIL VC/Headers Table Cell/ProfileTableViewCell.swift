//
//  ProfileTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var jobProfileTitleLbl: UILabel!
    @IBOutlet var jobNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
