//
//  SegmentedCtrlTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 10/06/21.
//

import UIKit

class SegmentedCtrlTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    var singleView: UIView!
    var doubleView: UIView!
    
    
    static let identifier = "SegmentedCtrlTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "SegmentedCtrlTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        singleView = SingleViewController().view
        doubleView = DoubleViewController().view
        viewContainer.addSubview(singleView)
        viewContainer.addSubview(doubleView)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchAction(_ sender: UISegmentedControl) {
        singleView.isHidden = true
        doubleView.isHidden = true
        switch sender.selectedSegmentIndex {
        case 0:
//            viewContainer.bringSubviewToFront(singleView)
//            doubleView.isHidden = false
//            break
            
            viewContainer.bringSubviewToFront(doubleView)
            singleView.isHidden = false
            break
        case 1:
//            viewContainer.bringSubviewToFront(doubleView)
//            singleView.isHidden = false
//            break
            
            
            viewContainer.bringSubviewToFront(singleView)
            doubleView.isHidden = false
            break
        default:
            break
        }
    }
    
}
