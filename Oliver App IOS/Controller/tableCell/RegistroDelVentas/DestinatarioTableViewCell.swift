//
//  DestinatarioTableViewCell.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 23/12/20.
//

import UIKit

class DestinatarioTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblTipo: UILabel!
    @IBOutlet weak var buttonDefinir: UIButton!
    @IBOutlet weak var buttonDefiniarConst: NSLayoutConstraint!
    @IBOutlet weak var subView: UIView!
    
    
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
