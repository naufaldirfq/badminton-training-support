//
//  SegmentedCtrlTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 10/06/21.
//

import UIKit

protocol SegmentedCtrlDelegate: UIViewController {
    func singleMatch(with match: Match)
    func doubleMatch(with match: Match)
}

class SegmentedCtrlTableViewCell: UITableViewCell {

    weak var delegate: SegmentedCtrlDelegate?
    @IBOutlet weak var singleView: UIView!
    @IBOutlet weak var singleFieldOne: UITextField!
    @IBOutlet weak var singleFieldTwo: UITextField!
    
    @IBOutlet weak var doubleView: UIStackView!
    @IBOutlet weak var doubleTeamOne: UIView!
    @IBOutlet weak var doubleFieldOne: UITextField!
    @IBOutlet weak var doubleFieldTwo: UITextField!
    @IBOutlet weak var doubleTeamTwo: UIView!
    @IBOutlet weak var doubleFieldThree: UITextField!
    @IBOutlet weak var doubleFieldFour: UITextField!
    
    @IBOutlet weak var doubleButton: UIButton!
    @IBOutlet weak var singleButton: UIButton!
    
    static let identifier = "SegmentedCtrlTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "SegmentedCtrlTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doubleView.isHidden = true
        doubleButton.isHidden = true
        setupStyles()
        setupDelegates()
    }
    
    func setupDelegates() {
        singleFieldOne.delegate = self
        singleFieldTwo.delegate = self
        doubleFieldOne.delegate = self
        doubleFieldTwo.delegate = self
        doubleFieldThree.delegate = self
        doubleFieldFour.delegate = self
    }
    
    func setupStyles() {
        singleView.layer.cornerRadius = 10.0
        singleFieldOne.text = "\(DummyData.Profile.name) (You)"
        singleFieldOne.isUserInteractionEnabled = false
        singleFieldTwo.placeholder = "Your opponent name"
        
        doubleTeamOne.layer.cornerRadius = 10.0
        doubleTeamTwo.layer.cornerRadius = 10.0
        doubleFieldOne.text = "\(DummyData.Profile.name) (You)"
        doubleFieldOne.isUserInteractionEnabled = false
        doubleFieldTwo.placeholder = "Your teammate name"
        doubleFieldThree.placeholder = "Your opponent name"
        doubleFieldFour.placeholder = "Your opponent name"
        
        singleButton.layer.cornerRadius = 10.0
        doubleButton.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            singleView.isHidden = false
            singleButton.isHidden = false
            doubleView.isHidden = true
            doubleButton.isHidden = true
        case 1:
            singleView.isHidden = true
            singleButton.isHidden = true
            doubleView.isHidden = false
            doubleButton.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func singleStartButton(_ sender: UIButton) {
        if let one = singleFieldOne.text, let two = singleFieldTwo.text {
            let match = Match(player1: one, player2: two)
            delegate?.singleMatch(with: match)
        }
    }
    
    @IBAction func doubleStartButton(_ sender: UIButton) {
        if let one = doubleFieldOne.text, let two = doubleFieldTwo.text, let three = doubleFieldThree.text, let four = doubleFieldFour.text {
            let match = Match(player1: one, player2: two, player3: three, player4: four)
            delegate?.doubleMatch(with: match)
        }
    }
}

extension SegmentedCtrlTableViewCell: UITextFieldDelegate {
    
}
