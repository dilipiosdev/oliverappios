//
//  SmileyTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 04/04/21.
//

import UIKit

class SmileyTableViewCell: UITableViewCell {
    @IBOutlet var stepLbl: UILabel!
    //Rating
    @IBOutlet weak var sliderStepRating: SliderStep!
    
    @IBOutlet var subViewbg: UIView!

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
    
}
