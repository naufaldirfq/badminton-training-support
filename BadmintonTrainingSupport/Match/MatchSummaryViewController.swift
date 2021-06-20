//
//  MatchSummaryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchSummaryViewController: UIViewController {
    
    var match: Match?
    
    @IBOutlet weak var matchSummaryTableView: UITableView!
    @IBOutlet weak var finishButton: UIButton!
    
    var disableButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Match Summary"
        finishButton.layer.cornerRadius = 10.0
        matchSummaryTableView.tableFooterView = UIView(frame: CGRect.zero)
        matchSummaryTableView.delegate = self
        matchSummaryTableView.dataSource = self
        matchSummaryTableView.register(NMImageTableViewCell.nib(), forCellReuseIdentifier: NMImageTableViewCell.identifier)
        matchSummaryTableView.register(SummaryMainInfoTableViewCell.nib(), forCellReuseIdentifier: SummaryMainInfoTableViewCell.identifier)
        matchSummaryTableView.register(ScoreTableCell.nib(), forCellReuseIdentifier: ScoreTableCell.identifier)
        matchSummaryTableView.register(FinishMatchCell.nib(), forCellReuseIdentifier: FinishMatchCell.identifier)
        
        if disableButton {
            finishButton.isHidden = true
        }
    }
    
    @IBAction func didTapFinishButton(_ sender: UIButton) {
        if let match = self.match{
            DummyData.history.dummyMatches.append(match)
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
extension MatchSummaryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                if let imgCell = tableView.dequeueReusableCell(withIdentifier: NMImageTableViewCell.identifier, for:  indexPath) as? NMImageTableViewCell{
                

                return imgCell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as? SummaryMainInfoTableViewCell{
                    if let match = self.match {
                        cell.configureCell(leftInfo: Formatter.date.string(from: match.date) , leftTitle: "Date", rightInfo: match.place, rightTitle: "Place")
                    }
                    return cell
                }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as? SummaryMainInfoTableViewCell{
                if let match = self.match {
                    cell.configureCell(leftInfo: match.type.rawValue, leftTitle: "Match Type", rightInfo: match.description, rightTitle: "Match Description")
                }
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableCell.identifier, for: indexPath) as? ScoreTableCell{
                if let match = self.match {
                    cell.configure(match: match)
                }
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as? SummaryMainInfoTableViewCell{
                if let match = self.match {
                    cell.configureCell(leftInfo: match.durationString, leftTitle: "Match Duration")
                }
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return Sizes.MatchSummary.ImageHeight
        case 1...2:
            return Sizes.MatchSummary.SummaryInfo
        case 3:
            return Sizes.MatchSummary.ScoreTable
        case 4:
            return Sizes.MatchSummary.SummaryInfo
        default:
            return UITableView.automaticDimension
        }
    }
}
