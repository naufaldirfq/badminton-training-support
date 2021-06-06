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
        tableView.register(RecentsCell.nib(), forCellReuseIdentifier: RecentsCell.identifier)
    }
    
    @objc func newTraining() {
        let vc = NewTrainingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return Sizes.TrainingCollection.Height
        case 1...2:
            return Sizes.Recents.Height
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
                cell.configure(name: "Recommendation", with: DummyData.Trainings)
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecentsCell.identifier) as? RecentsCell {
                cell.configure(name: "Recent Trainings", with: [])
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecentsCell.identifier) as? RecentsCell {
                cell.configure(name: "Recent Matches", with: [])
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
}

extension HomeViewController: TrainingCollectionDelegate {
    
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell) {
        print("Pressed \(trainingCell.name)!")
    }
    
}

extension HomeViewController: RecentsDelegate {
    
    func recentsView(cell: RecentsCell) {
        print("Pressed View All on \(cell.name)!")
    }
    
}
