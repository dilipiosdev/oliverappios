//
//  DestinatarioWithbuutonTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 25/12/20.
//

import UIKit

class DestinatarioWithbuttonTVC: UITableViewCell {


    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lnlTipo: UILabel!
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
