//
//  CreditoContactTableViewCell.swift
//  Oliver App IOS
//
//  Created by Vaibhav Awasthi on 24/01/21.
//

import UIKit

class CreditoContactTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblTipo: UILabel!
    @IBOutlet weak var lblEvlution: UILabel!
   
    @IBOutlet weak var buttonAsignar: UIButton!
    @IBOutlet weak var buttonEnviar: UIButton!
    
    @IBOutlet weak var subViewButton: UIView!
    
    @IBOutlet weak var buttonEvaluacion: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
