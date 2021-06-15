//
//  TrainingCollectionCell.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

protocol TrainingCollectionDelegate: UIViewController {
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell)

}

class TrainingCollectionCell: UITableViewCell {
    
    weak var delegate: TrainingCollectionDelegate?
    var name: String = "Collection Name"
    var trainings = [Training]()
    var width: CGFloat = Sizes.TrainingCollection.DefaultWidth
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    static let identifier = Identifiers.TrainingCollectionCell
    
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.TrainingCollectionCell, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
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
    
    public func configure(name: String, with trainings: [Training], width: CGFloat? = nil) {
        print(trainings)
        self.name = name
        self.trainings.append(contentsOf: trainings)
        self.width = width ?? self.width
        loadView()
        collectionView.reloadData()
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
        return CGSize(width: self.width, height: Sizes.TrainingCollection.CellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Sizes.TrainingCollection.EdgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCell.identifier, for: indexPath) as? TrainingCell {
            cell.configure(with: trainings[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TrainingCell {
            
            let training = trainings[indexPath.row]
            setTarget(with: training)
            
            self.delegate?.collectionView(trainingCell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }
    }
}

extension TrainingCollectionCell: BottomCardViewDelegate, UIViewControllerTransitioningDelegate {
    
    func bottomCardView(didTappedStartFor training: Training) {
        self.delegate?.dismiss(animated: true, completion: nil)
        let vc = TrainingSessionViewController()
        vc.session = training.uiSession
        self.delegate?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setTarget(with training: Training) {
        let slideVC = BottomCardViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.training = training
        slideVC.delegate = self
        self.delegate?.present(slideVC, animated: true, completion: nil)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BottomCardPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
