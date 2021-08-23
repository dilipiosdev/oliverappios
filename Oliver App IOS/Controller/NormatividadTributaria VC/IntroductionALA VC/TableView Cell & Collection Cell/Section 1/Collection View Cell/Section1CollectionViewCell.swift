//
//  Section1CollectionViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit

class Section1CollectionViewCell: UICollectionViewCell {
    static let identifier = "Section1CollectionViewCell"
    @IBOutlet var specificationLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var bottomBtn: UIButton!
    @IBOutlet var subViewbg: UIView!



    
    static func nib() -> UINib {
        return UINib(nibName: "Section1CollectionViewCell", bundle: nil)
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
