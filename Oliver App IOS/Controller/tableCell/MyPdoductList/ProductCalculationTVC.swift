//
//  ProductCalculationTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 29/12/20.
//

import UIKit

class ProductCalculationTVC: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var lblQuinity: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var lblPerPrice: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var buttonCancel: UIButton!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
