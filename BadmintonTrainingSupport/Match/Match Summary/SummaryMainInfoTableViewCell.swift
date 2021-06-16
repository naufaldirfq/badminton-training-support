//
//  SummaryMainInfoTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 15/06/21.
//

import UIKit

class SummaryMainInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var leftInfoLabel: UILabel!
    @IBOutlet weak var rightInfoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    static let identifier = Identifiers.SummaryMainInfoCell
    
    static func nib() -> UINib{
        return UINib(nibName:  Identifiers.SummaryMainInfoCell, bundle: nil)
    }
    func configureCell(leftInfo: String, leftTitle: String, rightInfo:String? = nil, rightTitle:String? = nil){
        leftTitleLabel.text = leftTitle
        leftInfoLabel.text = leftInfo
        if rightTitle != "" {
            rightInfoLabel.text = rightInfo == "" ? "N/A" : rightInfo
            rightTitleLabel.text = rightTitle
        } else {
            rightInfoLabel.isHidden = true
            rightTitleLabel.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
