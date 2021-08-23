//
//  PerOptionTableViewCell.swift
//  Oliver App IOS
//
//  Created by apple on 03/03/21.
//

import UIKit

protocol IngresosButtonProtocol: class {
    func ingresosEditButtonTapped()
}

class IngresosTableViewCell: UITableViewCell {
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var sueldoLabel: UILabel!
    @IBOutlet var horasExtraLabel: UILabel!
    @IBOutlet var asignacionLabel: UILabel!
    @IBOutlet var remuneracionLabel: UILabel!
    @IBOutlet var movLabel: UILabel!
    @IBOutlet var ctsLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    var delegate : IngresosButtonProtocol?
    
    
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
    
    @IBAction func ingresEditBtnTapped(_ sender: Any) {
        self.delegate?.ingresosEditButtonTapped()
        
        
    }
    
}
