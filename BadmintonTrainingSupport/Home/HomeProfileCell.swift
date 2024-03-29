//
//  HomeProfileTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 08/06/21.
//

import UIKit

class HomeProfileCell: UITableViewCell {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    static let identifier = Identifiers.HomeProfileCell
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    
    }
    
    func configure() {
        userNameLabel.text = UserProfile.name
        userPhotoImageView.image = UserProfile.photo
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
