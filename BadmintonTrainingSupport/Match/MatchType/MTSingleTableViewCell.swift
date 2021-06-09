//
//  MTSingleTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 08/06/21.
//

import UIKit

class MTSingleTableViewCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var mtLabelYourName: UILabel!
    @IBOutlet weak var mtField: UITextField!
    
    static let identifier = "MTSingleTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with yourName: String){
        mtLabelYourName.text = yourName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mtField.delegate = self
        mtField.placeholder = "Your opponent name"
        mtField.borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
