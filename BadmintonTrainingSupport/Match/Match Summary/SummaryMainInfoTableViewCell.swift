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
        // Initialization code
    }
    static let identifier = "SummaryMainInfoTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    func configureCell(leftInfo: String, leftTitle: String, rightInfo:String, rightTitle:String){
        leftTitleLabel.text = leftTitle
        leftInfoLabel.text = leftInfo
        rightInfoLabel.text = rightInfo
        rightTItleLabel.text = rightTitle
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
