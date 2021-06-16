//
//  FinishMatchCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 16/06/21.
//

import UIKit

class FinishMatchCell: UITableViewCell {

    @IBOutlet weak var finishButton: UIButton!
    var delegate: FinishMatchCellTapped!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    static let identifier = Identifiers.FinishMatchCell
    static func nib() -> UINib{
        return UINib(nibName: Identifiers.FinishMatchCell, bundle: nil)
    }
    
    func configure(isHidden: Bool) {
        finishButton.isHidden = isHidden
        finishButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func tapFinishButton(_ sender: Any) {
        self.delegate?.tapFinishButton()
    }
    
    
    
}
protocol FinishMatchCellTapped{
    func tapFinishButton()
}
