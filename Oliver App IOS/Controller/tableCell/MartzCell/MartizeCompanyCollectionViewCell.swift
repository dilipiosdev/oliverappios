//
//  MartizeCompanyCollectionViewCell.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 23/01/21.
//

import UIKit

class MartizeCompanyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEducativo: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    
    @IBOutlet weak var buttonSelectProduct: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
