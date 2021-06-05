//
//  TrainingCell.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class TrainingCell: UICollectionViewCell {
    
    var name: String = "Training Name"
    var desc: String = "Training description goes here..."
    var image: UIImage = Images.defaultTraining
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descLabel: UILabel!

    static let identifier = Identifiers.TrainingCell
    
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.TrainingCell, bundle: nil)
    }
    
    public func configure(with training: Training) {
        name = training.name
        desc = training.description
        image = training.image
        loadView()
    }
    
    func loadView() {
        nameLabel.text = name
        descLabel.text = desc
        imageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initImageView()
    }
    
    func initImageView() {
        imageView.layer.cornerRadius = Sizes.TrainingCollection.CornerRadius
        imageView.backgroundColor = .secondaryLabel
        imageView.tintColor = .systemBackground
    }
    
}
