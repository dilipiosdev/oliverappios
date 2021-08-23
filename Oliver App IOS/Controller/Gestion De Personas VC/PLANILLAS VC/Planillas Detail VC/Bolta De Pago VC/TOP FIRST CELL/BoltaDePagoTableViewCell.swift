//
//  ProfileTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

class BoltaDePagoTableViewCell: UITableViewCell {
    @IBOutlet var imgCompany: UIImageView!
    @IBOutlet var boletaDePagoLbl: UILabel!
    @IBOutlet var dsnDelLbl: UILabel!
    
    @IBOutlet var currentLastDayMonthYearLbl: UILabel!
    @IBOutlet weak var company_social_reason: UILabel!
    @IBOutlet weak var companyAddressLbl: UILabel!
    @IBOutlet weak var companyRUCLbl: UILabel!
    @IBOutlet weak var regimenBtn: UIButton!
    @IBOutlet weak var pequenaBtn: UIButton!
    @IBOutlet weak var microBtn: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        regimenBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        pequenaBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        microBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
