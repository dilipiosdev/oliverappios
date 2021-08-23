//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
protocol AddressDataButtonProtocol: class {
    func addressEditButtonTapped()
}

class AddressdataTableViewCell: UITableViewCell {
       @IBOutlet var subViewbg: UIView!
       @IBOutlet var addressLbl: UILabel!
       @IBOutlet var addReferenceLbl: UILabel!
       @IBOutlet var fixedPhoneLbl: UILabel!
       @IBOutlet var mobilePhoneLbl: UILabel!
       @IBOutlet var emailLbl: UILabel!
       @IBOutlet var emergencyNameLbl: UILabel!
       @IBOutlet var emergencyContactLbl: UILabel!
    var delegate : AddressDataButtonProtocol?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
               subViewbg.layer.cornerRadius = 5
               subViewbg.clipsToBounds = true
               subViewbg.layer.masksToBounds = false
               subViewbg.layer.shadowColor = UIColor.lightGray.cgColor
               subViewbg.backgroundColor = UIColor.white
               subViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
               subViewbg.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addressEditBtnTapped(_ sender: Any) {
        self.delegate?.addressEditButtonTapped()
    
    
    }
}
