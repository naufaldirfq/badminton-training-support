//
//  ScoreCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 15/06/21.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var score2Label: UILabel!
    @IBOutlet weak var score1Label: UILabel!
    @IBOutlet weak var score3Label: UILabel!
    @IBOutlet weak var TeamLabel: UILabel!
    
    var scoreLabels: [UILabel] = []
    override func awakeFromNib() {
        
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    
    static let identifier = Identifiers.ScoreCell
    static func nib() -> UINib{
        return UINib(nibName: Identifiers.ScoreCell, bundle: nil)
    }
    func configure(match: Match, index: Int) {
        let team = match.teams[index]
        let opponent = index == 0 ? match.teams[1] : match.teams[0]
        TeamLabel.text = team.playerNames
        scoreLabels = [score1Label, score2Label, score3Label]
        for (index, score) in team.teamScore.enumerated() {
            scoreLabels[index].text = String(score)
            if team.teamScore[index] > opponent.teamScore[index] {
                scoreLabels[index].textColor = Colors.AccentColor
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
