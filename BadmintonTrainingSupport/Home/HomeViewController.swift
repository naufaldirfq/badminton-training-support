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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingCollectionCell.nib(), forCellReuseIdentifier: TrainingCollectionCell.identifier)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, TrainingCollectionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.5+242
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
            cell.configure(name: "Physical", with: DummyData.Trainings)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell) {
        print("Pressed \(trainingCell.name)!")
    }
}
