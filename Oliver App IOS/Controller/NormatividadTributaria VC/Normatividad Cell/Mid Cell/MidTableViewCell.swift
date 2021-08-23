//
//  NegociosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit
protocol YesNoButtonSetProtocol: class {
    func yesNoButtonTapped(yesnoStr: Int, indexPath: IndexPath)
}

class MidTableViewCell: UITableViewCell {
    
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var btnMasDetail: UIButton!
    @IBOutlet var specificationLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var decretoLbl: UILabel!
    @IBOutlet var siBtn: UIButton!
    @IBOutlet var nOBtn: UIButton!
    var yesNoStr = String()
    var indexPath : IndexPath = []
    var delegate : YesNoButtonSetProtocol?


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    
        subViewbg.layer.cornerRadius = 5
        subViewbg.clipsToBounds = true
        
        subViewbg.layer.masksToBounds = false
        subViewbg.layer.shadowColor = UIColor.lightGray.cgColor
        subViewbg.backgroundColor = UIColor.white
        subViewbg.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        subViewbg.layer.shadowOpacity = 0.5
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func masDetailButtonTapped(_ sender: Any) {
           
    }
    
    @IBAction func siBtnTapped(_ sender: Any) {
        self.delegate?.yesNoButtonTapped(yesnoStr: 1, indexPath: self.indexPath)
        
      }
    
    @IBAction func noBtnTapped(_ sender: Any) {
        self.delegate?.yesNoButtonTapped(yesnoStr: 0, indexPath: self.indexPath)

           
         }
    
}
