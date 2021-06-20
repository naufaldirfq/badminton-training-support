//
//  MatchHistoryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchHistoryViewController: UIViewController {

    @IBOutlet weak var matchHistoryTableView: UITableView!
    
    var matches: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Match History"
        matches.append(contentsOf: DummyData.dummyMatches)
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
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchHistoryCell.identifier, for: indexPath) as! MatchHistoryCell
        
        cell.configure(with: matches[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MatchSummaryViewController()
        vc.disableButton = true
        vc.match = matches[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
