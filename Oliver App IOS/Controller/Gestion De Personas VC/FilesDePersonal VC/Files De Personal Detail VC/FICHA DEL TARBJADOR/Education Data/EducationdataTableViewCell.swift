//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
protocol  EducationDataButtonProtocol: class {
    func educationEditButtonTapped()
}
class EducationdataTableViewCell: UITableViewCell {
       @IBOutlet var subViewbg: UIView!
       @IBOutlet var academicDegreeLbl: UILabel!
       @IBOutlet var institutionTypeLbl: UILabel!
       @IBOutlet var institutionNameLbl: UILabel!
       @IBOutlet var degreeLbl: UILabel!
       @IBOutlet var outYearLbl: UILabel!
    var delegate : EducationDataButtonProtocol?
       


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
    @IBAction func educationEditBtnTapped(_ sender: Any) {
        self.delegate?.educationEditButtonTapped()
       
       
       }
    
}
