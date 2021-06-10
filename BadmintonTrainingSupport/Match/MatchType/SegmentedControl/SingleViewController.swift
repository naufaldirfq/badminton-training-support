//
//  SingleViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 10/06/21.
//

import UIKit

class SingleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fieldYourName: UITextField!
    @IBOutlet weak var fieldOpponentName: UITextField!
  
    public func configure(with yourName: String){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldYourName.delegate = self
        fieldOpponentName.delegate = self
//        let tempName: String?
//        tempName = DummyData.DataProfile[0]
        let flag: String
        flag = " (You)"
        
        fieldYourName.text = "Hanif Fauzi" + flag
        style()
        
    }

    
    func style(){
        containerView.layer.cornerRadius = 10
        //MARK: placeholder & style
        fieldYourName.attributedPlaceholder = NSAttributedString(string: "Your name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])
        fieldOpponentName.attributedPlaceholder = NSAttributedString(string: "Your opponent name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])
        //fieldOpponentName.borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}
