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
        return UINib(nibName: "TextFieldTableViewCell", bundle: nil)
    }
  
    
    public func configure(with name: String, placeholderTemp: String) {
        labelField.text = name
        nwField.attributedPlaceholder = NSAttributedString(string: placeholderTemp, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])
    }
    
    public func configureDate(with currentDate: String){
        nwField.text = currentDate
    }
    
    public func configureTemp(with dates: String){
        nwField.text = dates
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nwField.delegate = self
        nwField.borderStyle = UITextField.BorderStyle.roundedRect
        //nwField.font = UIFont(name: "Lato-Bold", size: 13)
        //SF Pro Display-Bold /
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        print("\(nwField.text ?? "")")
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
