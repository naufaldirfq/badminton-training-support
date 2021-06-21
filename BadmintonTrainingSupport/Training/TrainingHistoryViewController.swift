//
//  TrainingHistoryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit
import Firebase

class TrainingHistoryViewController: UIViewController {
    
    @IBOutlet weak var trainingHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        navigationItem.title = "Training History"
    }
    
    func initTableView() {
        trainingHistoryTableView.dataSource = self
        trainingHistoryTableView.delegate = self
        trainingHistoryTableView.register(TrainingHistoryTableViewCell.nib(), forCellReuseIdentifier:TrainingHistoryTableViewCell.identifier)
    }
}
extension TrainingHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Local.data.trainingHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrainingHistoryTableViewCell.identifier, for: indexPath) as! TrainingHistoryTableViewCell
        let trainings = Local.data.trainingHistory
        cell.configure(with: trainings[trainings.count - 1 - indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TrainingSessionViewController()
        vc.isSummary = true
        let trainings = Local.data.trainingHistory
        let training = trainings[trainings.count - 1 - indexPath.row]
        vc.session = training
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
