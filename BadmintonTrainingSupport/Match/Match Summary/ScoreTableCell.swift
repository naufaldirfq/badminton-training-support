//
//  ScoreTableCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 15/06/21.
//

import UIKit

class ScoreTableCell: UITableViewCell {
    var team :[Team] = DummyData.Teams
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scoreTable: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        initTableView()
        
        // Initialization code
    }
    func initTableView() -> () {
        self.scoreTable.dataSource = self
        self.scoreTable.delegate = self
        self.scoreTable.register(ScoreCell.nib() , forCellReuseIdentifier: ScoreCell.identifier)
    }
    func configure(match: Match){
        
    }
    static let identifier = Identifiers.ScoreTabelCell
    static func nib() -> UINib{
        return UINib(nibName: Identifiers.ScoreTabelCell, bundle: nil)
    }
    
}
extension ScoreTableCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.identifier, for: indexPath) as! ScoreCell
        cell.configure(team: team[indexPath.row])
        return cell
    }
    
    
}