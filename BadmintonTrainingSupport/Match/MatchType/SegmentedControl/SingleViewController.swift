//
//  SingleViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 10/06/21.
//

import UIKit

class SingleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelYourName: UILabel!
    @IBOutlet weak var fieldOpponentName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldOpponentName.delegate = self
        style()

    }
    
    func style(){
        //MARK: placeholder & style
        fieldOpponentName.attributedPlaceholder = NSAttributedString(string: "Your opponent name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])
        fieldOpponentName.borderStyle = UITextField.BorderStyle.roundedRect
        
        //fieldOpponentName.font = UIFont(name: "Lato-Bold", size: 13)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}
