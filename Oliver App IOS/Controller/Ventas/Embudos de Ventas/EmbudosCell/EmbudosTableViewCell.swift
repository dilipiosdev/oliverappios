//
//  EmbudosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 08/02/21.
//

import UIKit

class EmbudosTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCustomerType: UILabel!
    @IBOutlet weak var lblPersent: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var buttonSearch: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
