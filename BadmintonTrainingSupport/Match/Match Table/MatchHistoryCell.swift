//
//  MatchHistoryCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 09/06/21.
//

import UIKit

class MatchHistoryCell: UITableViewCell {

    @IBOutlet weak var matchSummaryLabel: UILabel!
    @IBOutlet weak var teamBLabel: UILabel!
    @IBOutlet weak var teamALabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with match: Match) {
        teamALabel.text = match.player1 + "\n" + match.player2
        teamBLabel.text = match.player3 + "\n" + match.player4
        let matchSet = NSAttributedString(string: "\n" + String( match.matchSet) + " sets")
        let mystring = match.getOverallMatchStatus()
        mystring.append(matchSet)
        matchSummaryLabel.attributedText = mystring
        
        
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