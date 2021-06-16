//
//  SummaryMainInfoTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 15/06/21.
//

import UIKit

class SummaryMainInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var rightTItleLabel: UILabel!
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
    func configureCell(leftInfo: String, leftTitle: String, rightInfo:String, rightTitle:String){
        leftTitleLabel.text = leftTitle
        leftInfoLabel.text = leftInfo
        rightInfoLabel.text = rightInfo
        rightTItleLabel.text = rightTitle
    }
    func configureCell(leftInfo: String, leftTitle: String){
        leftTitleLabel.text = leftTitle
        leftInfoLabel.text = leftInfo
        rightInfoLabel.isHidden = true
        rightTItleLabel.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
