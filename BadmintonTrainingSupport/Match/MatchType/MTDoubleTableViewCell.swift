//
//  MTDoubleTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 09/06/21.
//

import UIKit

class MTDoubleTableViewCell: UITableViewCell {

    @IBOutlet weak var viewTeammate: UIView!
    @IBOutlet weak var viewOpponent: UIView!
    
    @IBOutlet weak var mtLabelYourName: UILabel!
    @IBOutlet weak var mtFieldTeammateName: UITextField!
    
    @IBOutlet weak var mtFieldOpponentName1: UITextField!
    @IBOutlet weak var mtFieldOpponentName2: UITextField!
    
    static let identifier = "MTDoubleTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "MTDoubleTableViewCell", bundle: nil)
    }
    
    public func configure(with name: String){
        mtLabelYourName.text = name
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewTeammate.layer.cornerRadius = 10
        viewOpponent.layer.cornerRadius = 10
        
//        mtFieldTeammateName.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
