//
//  MatchHistoryCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 09/06/21.
//

import UIKit

class MatchHistoryCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var matchSummaryLabel: UILabel!
    @IBOutlet weak var teamBLabel: UILabel!
    @IBOutlet weak var teamALabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with match: Match) {
        teamALabel.text = match.teams[0].playerNames
        teamBLabel.text = match.teams[1].playerNames
        let matchStatus = match.matchStatus
        let numberOfSets = NSAttributedString(string: "\n\(match.numberOfSets) Sets")
        matchStatus.append(numberOfSets)
        matchSummaryLabel.attributedText = matchStatus
        cardView.layer.borderWidth = 0.25
        cardView.layer.borderColor = UIColor.secondaryLabel.cgColor
        cardView.layer.cornerRadius = 10
        selectionStyle = .none
    }
    
    static let identifier = Identifiers.MatchHistoryCell
    
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.MatchHistoryCell, bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
