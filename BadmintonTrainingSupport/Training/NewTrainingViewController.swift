//
//  NewTrainingViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class NewTrainingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Training"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingCollectionCell.nib(), forCellReuseIdentifier: TrainingCollectionCell.identifier)
    }
    

}

extension NewTrainingViewController: UITableViewDelegate, UITableViewDataSource, TrainingCollectionDelegate, UIViewControllerTransitioningDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DummyData.Categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Sizes.TrainingCollection.Height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
            let category = DummyData.Categories[indexPath.row]
            cell.configure(name: category.name, with: category.trainings)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell) {
        print("Pressed \(trainingCell.name)!")
        setTarget()
    }
    
    @objc func setTarget() {
        let slideVC = BottomCardViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BottomCardPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
