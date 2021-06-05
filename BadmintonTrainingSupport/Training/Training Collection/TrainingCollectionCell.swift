//
//  TrainingCollectionCell.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class TrainingCollectionCell: UITableViewCell {
    
    var name: String = "Collection Name"
    var trainings = [Training]()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    static let identifier = Identifiers.TrainingCollectionCell
    
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.TrainingCollectionCell, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCollectionView()
    }
    
    func initCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(TrainingCell.nib(), forCellWithReuseIdentifier: TrainingCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(name: String, with trainings: [Training]) {
        self.name = name
        self.trainings.append(contentsOf: trainings)
        loadView()
    }
    
    func loadView() {
        self.nameLabel.text = name
    }
    
}

extension TrainingCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 242)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCell.identifier, for: indexPath) as? TrainingCell {
            cell.configure(with: trainings[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
}
