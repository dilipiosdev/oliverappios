//
//  MartizCollectionViewCell.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 22/01/21.
//

import UIKit

class MartizCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEducativo: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    
    
    @IBOutlet weak var lblZona: UILabel!
    @IBOutlet weak var lblTrabaha: UILabel!
    @IBOutlet weak var lblIngresos: UILabel!
 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var buttonSelectProduct: UIButton!
}
