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
    
    static let identifier = Identifiers.TrainingHistoryCell
    public func configure(with training: TrainingSession) {
        trainingNameLabel.text = training.trainingName
        recentsLabel.text = training.getDateRelativity()
        measurement1Label.text = training.trainingMeasurement[0]
        measurement2Label.text = training.trainingMeasurement[1]
        unit1Label.text = String(training.trainingResult[0])
        unit2Label.text = String(training.trainingResult[1])
        
        
    }
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.TrainingHistoryCell, bundle: nil)
    }
}
