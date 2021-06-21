//
//  TrainingHistoryTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 07/06/21.
//

import UIKit

class TrainingHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var recentsLabel: UILabel!
    @IBOutlet weak var measurement1Label: UILabel!
    @IBOutlet weak var measurement2Label: UILabel!
    @IBOutlet weak var unit1Label: UILabel!
    @IBOutlet weak var unit2Label: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    static let identifier = Identifiers.TrainingHistoryCell
    
    public func configure(with training: TrainingSession) {
        trainingNameLabel.text = training.name
        recentsLabel.text = training.getDateRelativity()
        if training.name == "Running" {
            measurement1Label.text = "Distance"
            measurement2Label.text = "Time"
            unit1Label.text = "\(training.distance) km"
            unit2Label.text = "\(training.time) min"
        }
        else {
            measurement1Label.text = "Set"
            measurement2Label.text = "Time/Set"
            unit1Label.text = String(training.set)
            unit2Label.text = "\(training.repetition) sec"
        }
        cardView.layer.borderWidth = 0.25
        cardView.layer.borderColor = UIColor.secondaryLabel.cgColor
        cardView.layer.cornerRadius = 10
        selectionStyle = .none
    }
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.TrainingHistoryCell, bundle: nil)
    }
}
