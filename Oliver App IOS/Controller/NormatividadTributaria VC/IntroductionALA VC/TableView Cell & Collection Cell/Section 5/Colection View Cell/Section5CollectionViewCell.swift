//
//  Section1CollectionViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 23/02/21.
//

import UIKit
protocol Section5CellDelegate : class {
    func didTapVerBtn(indexpath: IndexPath)
}
class Section5CollectionViewCell: UICollectionViewCell {
    static let identifier = "Section5CollectionViewCell"
    @IBOutlet var bottomBtn: UIButton!
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var topLbl: UILabel!
    var delegate: Section5CellDelegate!
    var indexPath :IndexPath = []
    
    static func nib() -> UINib {
        return UINib(nibName: "Section5CollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
               subViewbg.layer.cornerRadius = 5
               subViewbg.clipsToBounds = true
               subViewbg.layer.masksToBounds = false
               subViewbg.layer.shadowColor = UIColor.lightGray.cgColor
               subViewbg.backgroundColor = UIColor.white
               subViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
               subViewbg.layer.shadowOpacity = 0.5
        
    }
    
    @IBAction func verBtnTapped(_ sender: Any) {
        print(indexPath.row)
        self.delegate?.didTapVerBtn(indexpath: indexPath)
        
    }

}


   
