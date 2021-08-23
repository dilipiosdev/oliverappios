//
//  ProgressViewTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 28/02/21.
//

import UIKit

class ProgressViewTableViewCell: UITableViewCell {
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
