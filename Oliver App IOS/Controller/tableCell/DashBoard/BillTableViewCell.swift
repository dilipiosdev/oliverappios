//
//  MyProductTableViewCell.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 28/12/20.
//

import UIKit

class BillTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var labelHeaderTime: UILabel!
    
    @IBOutlet weak var labelJan: UILabel!
    @IBOutlet weak var labelFeb: UILabel!
    @IBOutlet weak var labelMAr: UILabel!
    @IBOutlet weak var labelApril: UILabel!
    @IBOutlet weak var labelMay: UILabel!
    @IBOutlet weak var labelJun: UILabel!
    @IBOutlet weak var labelJuly: UILabel!
    @IBOutlet weak var labelAug: UILabel!
    @IBOutlet weak var labelSep: UILabel!
    @IBOutlet weak var labelOctober: UILabel!
    @IBOutlet weak var labelNov: UILabel!
    @IBOutlet weak var labelDec: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
