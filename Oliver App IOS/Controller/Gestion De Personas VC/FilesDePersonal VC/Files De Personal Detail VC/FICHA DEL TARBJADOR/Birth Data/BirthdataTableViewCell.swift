//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

protocol BirthDataButtonProtocol: class {
    func birthEditButtonTapped()
}

class BirthdataTableViewCell: UITableViewCell {
       @IBOutlet var subViewbg: UIView!
       @IBOutlet var nationalityLbl: UILabel!
       @IBOutlet var departmentLbl: UILabel!
       @IBOutlet var provinceLbl: UILabel!
       @IBOutlet var districtLbl: UILabel!
       @IBOutlet var dobLbl: UILabel!
       @IBOutlet var docTypeLbl: UILabel!
       @IBOutlet var docNumberLbl: UILabel!
    var delegate : BirthDataButtonProtocol?


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
    
    @IBAction func birthEditBtnTapped(_ sender: Any) {
        self.delegate?.birthEditButtonTapped()
          
          
          }
    
}
