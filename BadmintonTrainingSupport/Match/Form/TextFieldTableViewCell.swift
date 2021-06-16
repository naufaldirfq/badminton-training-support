//
//  TextFieldTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 07/06/21.
//

import UIKit

protocol TextFieldCellDelegate: UIViewController {
    func textField(with text: String, didFinishEditingFor textField: MatchFormTextField)
}

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: TextFieldCellDelegate?
    var field: MatchFormTextField?
    
    static let identifier = "TextFieldTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TextFieldTableViewCell", bundle: nil)
    }
  
    
    public func configure(with name: String, for field: MatchFormTextField, placeholderTemp: String? = nil, readonly: Bool = false) {
        labelField.text = name
        self.field = field
        if let placeholder = placeholderTemp {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])
        }
        textField.isUserInteractionEnabled = !readonly
    }
    
    public func configureDate(with currentDate: String){
        textField.text = currentDate
    }
    
    public func configureTemp(with dates: String){
        textField.text = dates
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        textField.borderStyle = UITextField.BorderStyle.roundedRect
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let field = self.field {
            delegate?.textField(with: text, didFinishEditingFor: field)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
