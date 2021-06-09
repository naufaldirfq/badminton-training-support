//
//  TextFieldTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 07/06/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var nwField: UITextField!
    
    static let identifier = "TextFieldTableViewCell"
    
    static func nib() -> UINib {
//        return UINib(nibName: identifier, bundle: nil)
        return UINib(nibName: "TextFieldTableViewCell", bundle: nil)
    }
  
    
    public func configure(with name: String, placeholderTemp: String) {
        labelField.text = name
        //nwField.placeholder = placeholderTemp
        
        nwField.attributedPlaceholder = NSAttributedString(string: placeholderTemp, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Times New Roman", size: 13)!])
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //nwField.placeholder = "Enter text..."
        nwField.delegate = self
        nwField.borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        print("\(nwField.text ?? "")")
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
