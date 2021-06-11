//
//  TrainingHistoryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class TrainingHistoryViewController: UIViewController {
    let trainingHistory = DummyData.TrainingHistory
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
        return trainingHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrainingHistoryTableViewCell.identifier, for: indexPath) as! TrainingHistoryTableViewCell
        cell.configure(with: trainingHistory[indexPath.row])
        return cell
    }
    
    
}
