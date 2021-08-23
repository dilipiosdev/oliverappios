//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit
protocol  CompanyWorkerDataButtonProtocol: class {
    func companyWorkerEditButtonTapped()
}

class WorkerdataTableViewCell: UITableViewCell {
       @IBOutlet var subViewbg: UIView!
       @IBOutlet var beginWorkingLbl: UILabel!
       @IBOutlet var paymentAmountLbl: UILabel!
       @IBOutlet var subVentionLbl: UILabel!
       @IBOutlet var lbrTimeStarEndLbl: UILabel!
       @IBOutlet var lunchTimeStartEndLbl: UILabel!
       @IBOutlet var hoursPerWeekLbl: UILabel!
       @IBOutlet var lbrRegimenLbl: UILabel!
       @IBOutlet var workingTypeLbl: UILabel!
       @IBOutlet var contractTypeLbl: UILabel!
       @IBOutlet var paymentFreqLbl: UILabel!
       @IBOutlet var paymentTypeLbl: UILabel!
    var delegate: CompanyWorkerDataButtonProtocol?


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
    @IBAction func workerDataEditBtnTapped(_ sender: Any) {
        self.delegate?.companyWorkerEditButtonTapped()
               
               
               }
      
    
}
