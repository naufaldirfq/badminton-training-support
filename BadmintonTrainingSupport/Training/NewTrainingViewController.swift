//
//  NewTrainingViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit
import Firebase

class NewTrainingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var home = HomeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Training"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingCollectionCell.nib(), forCellReuseIdentifier: TrainingCollectionCell.identifier)
    }
}

extension NewTrainingViewController: UITableViewDelegate, UITableViewDataSource, TrainingCollectionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Local.data.categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Sizes.TrainingCollection.Height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
            let category = Local.data.categories[indexPath.row]
            cell.configure(name: category.name, with: category.trainings, width: 140)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell) {
        print("Pressed \(trainingCell.name)!")
    }
}
