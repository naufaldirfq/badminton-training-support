//
//  MatchHistoryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchHistoryViewController: UIViewController {

    @IBOutlet weak var matchHistoryTableView: UITableView!
    
    let matches: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        // Do any additional setup after loading the view.
    }
    func initTableView() {
        matchHistoryTableView.dataSource = self
        matchHistoryTableView.delegate = self
        matchHistoryTableView.register(MatchHistoryCell.nib(), forCellReuseIdentifier:MatchHistoryCell.identifier)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MatchHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return match.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchHistoryCell.identifier, for: indexPath) as! MatchHistoryCell
        
        cell.configure(with: matches[indexPath.row])
        
        return cell
    }
    
    
}
