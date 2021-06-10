//
//  DoubleViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 10/06/21.
//

import UIKit

class DoubleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var containerViewTeammate: UIView!
    @IBOutlet weak var containerViewOpponent: UIView!
    @IBOutlet weak var fieldTeammateName: UITextField!
    
    @IBOutlet weak var fieldOpponentName1: UITextField!
    @IBOutlet weak var fieldOpponentName2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        style()
    }
    
    func style(){
        containerViewTeammate.layer.cornerRadius = 10
        containerViewOpponent.layer.cornerRadius = 10
        
        
        fieldTeammateName.attributedPlaceholder = NSAttributedString(string: "Your teammate name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])
        fieldOpponentName1.attributedPlaceholder = NSAttributedString(string: "Your opponent name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])
        fieldOpponentName2.attributedPlaceholder = NSAttributedString(string: "Your opponent name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Helvetica", size: 13)!])


    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    //MARK: Keyboard


}
