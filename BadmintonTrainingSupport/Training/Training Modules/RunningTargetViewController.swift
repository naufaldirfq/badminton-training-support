//
//  RunningTargetViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 14/06/21.
//

import UIKit

class RunningTargetViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }

    func setupTextField(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 3.0)
        bottomLine.backgroundColor = UIColor.label.resolvedColor(with: view.traitCollection).cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }

}
