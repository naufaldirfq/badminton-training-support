//
//  BtnStartMatchTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 08/06/21.
//

import UIKit

class BtnStartMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var nmBtnStart: UIButton!
    
    static let identifier = "BtnStartMatchTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "BtnStartMatchTableViewCell", bundle: nil)
    }
    
//    public func configure(with nameBtn: String){
//        //Configure potong
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nmBtnStart.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
