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
    override func awakeFromNib() {
        
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    static let identifier = Identifiers.ScoreCell
    static func nib() -> UINib{
        return UINib(nibName: Identifiers.ScoreCell, bundle: nil)
    }
    func configure(team : Team)->(){
        TeamLabel.text = ""

        TeamLabel.text = team.players[0]
        if team.players.count == 2 {
            TeamLabel.text = TeamLabel.text! + "\n" + team.players[1]
        }
        
        if team.teamScore.count >= 1 {
            score1Label.text = String(team.teamScore[0])
            if team.teamScore.count >= 2 {
                score2Label.text = String(team.teamScore[1])
                if team.teamScore.count >= 3 {
                    score3Label.text = String(team.teamScore[2])
                }
            }
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
