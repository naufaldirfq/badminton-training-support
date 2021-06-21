//
//  SetRepTargetViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 21/06/21.
//

import UIKit

class SetRepTargetViewController: TrainingTargetViewController {

    @IBOutlet weak var setsTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var breakTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(for: setsTextField)
        setupTextField(for: timeTextField)
        setupTextField(for: breakTextField)
    }
    
    func setupTextField(for textField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height + 8, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.label.resolvedColor(with: view.traitCollection).cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
        textField.delegate = self
    }
}

extension SetRepTargetViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case setsTextField:
            delegate?.session?.set = Int(textField.text ?? "0") ?? 0
        case timeTextField:
            delegate?.session?.repetition = Int(textField.text ?? "0") ?? 0
        case breakTextField:
            delegate?.session?.breakTime = Int(textField.text ?? "0") ?? 0
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
