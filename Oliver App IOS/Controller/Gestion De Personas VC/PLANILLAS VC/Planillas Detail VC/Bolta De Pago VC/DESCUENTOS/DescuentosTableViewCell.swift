//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

protocol DesuentosButtonProtocol: class {
    func desuentosEditButtonTapped()
}


class DescuentosTableViewCell: UITableViewCell {
       @IBOutlet var subViewbg: UIView!

       @IBOutlet var afpFondoLbl: UILabel!
       @IBOutlet var afpCommisionLbl: UILabel!
       @IBOutlet var onpLbl: UILabel!
       @IBOutlet var fatlasLbl: UILabel!
       @IBOutlet var reten4taCatLbl: UILabel!
       @IBOutlet var reten5taCatLbl: UILabel!
       @IBOutlet var retenJudicialLbl: UILabel!
       @IBOutlet var adelantosLbl: UILabel!
       @IBOutlet var totalLbl: UILabel!

    
 
    var delegate : DesuentosButtonProtocol?



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
    @IBAction func desuentosEditButtonTapped(_ sender: Any) {
               self.delegate?.desuentosEditButtonTapped()
               
               }
      
    
}
