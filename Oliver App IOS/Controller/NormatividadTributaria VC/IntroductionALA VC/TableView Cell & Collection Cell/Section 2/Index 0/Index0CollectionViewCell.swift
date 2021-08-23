//
//  Section1CollectionViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit

class Index0CollectionViewCell: UICollectionViewCell {
    static let identifier = "Index0CollectionViewCell"
    @IBOutlet var bottomBtn: UIButton!
    @IBOutlet var subViewbg: UIView!


    static func nib() -> UINib {
        return UINib(nibName: "Index0CollectionViewCell", bundle: nil)
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
