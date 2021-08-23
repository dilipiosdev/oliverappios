//
//  EmisionDeBoletasTVC.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 20/12/20.
//

import UIKit

class EmisionDeBoletasTVC: UITableViewCell {
    @IBOutlet weak var lblBilID: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblBillAmount: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var buttonBottom: UIButton!
    @IBOutlet weak var bottomButtonheightConst: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subView.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
