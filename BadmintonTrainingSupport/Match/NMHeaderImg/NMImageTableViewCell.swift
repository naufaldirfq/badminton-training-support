//
//  NMImageTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 08/06/21.
//

import UIKit

class NMImageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newMatchImg: UIImageView!
    var image: UIImage = Images.defaultTraining
    
    static let idetifier = "NMImageTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "NMImageTableViewCell", bundle: nil)
    }
/*
    public func configure(with imgName: Training){
        //MARK: image
        image = imgName.image
        loadView()
    }
    
    func loadView() {
        newMatchImg.image = image
    }
 */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newMatchImg.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
