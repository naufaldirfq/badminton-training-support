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
    
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.TrainingHistoryCell, bundle: nil)
    }
}
