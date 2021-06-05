//
//  HomeViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Training", style: .done, target: self, action: #selector(newTraining))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingCollectionCell.nib(), forCellReuseIdentifier: TrainingCollectionCell.identifier)
    }
    
    @objc func newTraining() {
        let vc = NewTrainingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, TrainingCollectionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Sizes.TrainingCollection.Height
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
            cell.configure(name: "Recommendation", with: DummyData.Trainings)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell) {
        print("Pressed \(trainingCell.name)!")
    }
}
