//
//  NMImageTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 08/06/21.
//

import UIKit

class NMImageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newMatchImg: UIImageView!
    var image: UIImage = #imageLiteral(resourceName: "new_match")
    
    static let identifier = "NMImageTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newMatchImg.image = image
        newMatchImg.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
