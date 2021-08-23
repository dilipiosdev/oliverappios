//
//  ProfileTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

class NetoTableViewCell: UITableViewCell {
    @IBOutlet var netoAPagarBtn: UIButton!
    @IBOutlet var registrarBoletaBtn: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func registerBoletaDeBtnTapped(_ sender: Any) {
        
    }
    
}
