//
//  MatchHistoryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchHistoryViewController: UIViewController {

    @IBOutlet weak var matchHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Match History"
        initTableView()
    }
    
    func initTableView() {
        matchHistoryTableView.dataSource = self
        matchHistoryTableView.delegate = self
        matchHistoryTableView.register(MatchHistoryCell.nib(), forCellReuseIdentifier:MatchHistoryCell.identifier)
    }

}

extension MatchHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Local.data.matchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchHistoryCell.identifier, for: indexPath) as! MatchHistoryCell
        let matches = Local.data.matchHistory
        cell.configure(with: matches[matches.count - 1 - indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MatchSummaryViewController()
        vc.disableButton = true
        let matches = Local.data.matchHistory
        vc.match = matches[matches.count - 1 - indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
