//
//  NegociosTableViewCell.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit
protocol AddressUpdateProtocol: class {
    func didUpdateUserAddress(cell:HeaderFunctionTableViewCell)
}
class HeaderFunctionTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var subViewbg: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var valueTF: UITextField!
    var delegate: AddressUpdateProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        self.delegate?.didUpdateUserAddress(cell: self)
    }
    
}
