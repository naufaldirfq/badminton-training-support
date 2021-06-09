//
//  ChoiceTypeTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 08/06/21.
//

import UIKit

class ChoiceTypeTableViewCell: UITableViewCell {

    
    static let identifier = "ChoiceTypeTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ChoiceTypeTableViewCell", bundle: nil)
    }
    
//    public func configure(with yourName: String){
//        mtLabelYourName.text = yourName
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didChangeType(_ sender: UISegmentedControl) {

        var nibToLoad = UINib()
        switch sender.selectedSegmentIndex {
        case 0:
            nibToLoad = UINib(nibName: "MTSingleTableViewCell", bundle: nil)
        case 1:
            nibToLoad = UINib(nibName: "MTDoubleTableViewCell", bundle: nil)
            
        default:
            print("default")
        }
 
        
        
        
    }
    

    
}
