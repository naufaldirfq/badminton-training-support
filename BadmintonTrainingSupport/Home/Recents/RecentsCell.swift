//
//  RecentsCell.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

enum RecentsType: String {
    case training = "Recent Trainings"
    case match = "Recent Matches"
}

protocol RecentsDelegate: UIViewController {
    func recentsView(didTapViewAllIn cell: RecentsCell)
    func recentsView(recent: UITableViewCell, index: Int, didTapRecentIn cell: RecentsCell)
}

class RecentsCell: UITableViewCell {
    
    weak var delegate: RecentsDelegate?
    var type: RecentsType?
    
    var trainings: [TrainingSession] = []
    var matches: [Match] = []
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var viewAllButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    static let identifier = Identifiers.RecentsCell
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupTableView()
       
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = Sizes.Recents.CornerRadius
        tableView.register(TrainingHistoryTableViewCell.nib(), forCellReuseIdentifier: TrainingHistoryTableViewCell.identifier)
        tableView.register(MatchHistoryCell.nib(), forCellReuseIdentifier: MatchHistoryCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(type: RecentsType, trainings: [TrainingSession] = [], matches: [Match] = []) {
        self.type = type
        switch type {
        case .match:
            self.matches = matches
            tableView.isHidden = matches.isEmpty ? true : false
            emptyLabel.text = "There is no match yet!\nGo play some matches"
        case .training:
            self.trainings = trainings
            tableView.isHidden = trainings.isEmpty ? true : false
            emptyLabel.text = "There is no training yet!\nGo do some training!"
        }
        nameLabel.text = type.rawValue
        tableView.reloadData()
    }
    
    @IBAction func didTapViewAll(_ sender: UIButton) {
        switch type {
        case .training:
            let vc = TrainingHistoryViewController()
            delegate?.navigationController?.pushViewController(vc, animated: true)
        case .match:
            let vc = MatchHistoryViewController()
            delegate?.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        delegate?.recentsView(didTapViewAllIn: self)
    }

}

extension RecentsCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = type == .training ? trainings.count : matches.count
        return count > 3 ? 3 : count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Sizes.Recents.CellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .training:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainingHistoryTableViewCell.identifier, for: indexPath) as! TrainingHistoryTableViewCell
            cell.configure(with: trainings[trainings.count - indexPath.row - 1])
            return cell
        case .match:
            let cell = tableView.dequeueReusableCell(withIdentifier: MatchHistoryCell.identifier, for: indexPath) as! MatchHistoryCell
            cell.configure(with: matches[matches.count - indexPath.row - 1])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .training:
            let vc = TrainingSessionViewController()
            vc.disableButton = true
            delegate?.navigationController?.pushViewController(vc, animated: true)
        case .match:
            let vc = MatchSummaryViewController()
            vc.disableButton = true
            vc.match = matches[matches.count - 1 - indexPath.row]
            delegate?.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            delegate?.recentsView(recent: cell, index: indexPath.row, didTapRecentIn: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
