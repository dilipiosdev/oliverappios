//
//  Section1CollectionViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit

class Section2CollectionViewCell: UICollectionViewCell {
    static let identifier = "Section2CollectionViewCell"
    @IBOutlet var bottomBtn: UIButton!
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var topLbl: UILabel!
    @IBOutlet var denominacionLbl: UILabel!
    @IBOutlet var numeroLbl: UILabel!
    @IBOutlet var organisationLbl: UILabel!
    @IBOutlet var capitalLbl: UILabel!





    
    static func nib() -> UINib {
        return UINib(nibName: "Section2CollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        subViewbg.layer.cornerRadius = 5
               subViewbg.clipsToBounds = true
               
               subViewbg.layer.masksToBounds = false
               subViewbg.layer.shadowColor = UIColor.lightGray.cgColor
               subViewbg.backgroundColor = UIColor.white
               subViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
               subViewbg.layer.shadowOpacity = 0.5    }

}
