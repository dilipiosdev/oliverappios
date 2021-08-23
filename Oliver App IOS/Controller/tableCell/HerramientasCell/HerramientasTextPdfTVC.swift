//
//  HerramientasTextPdfTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 18/12/20.
//

import UIKit

class HerramientasTextPdfTVC: UITableViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var subViewButton: UIView!
    @IBOutlet weak var subViewBuuton1: UIView!
    @IBOutlet weak var imgViewLeft: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subView.layer.cornerRadius = 8
        subViewButton.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
