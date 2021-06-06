//
//  RecentsCell.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

protocol RecentsDelegate: UIViewController {
    func recentsView(didTapViewAllIn cell: RecentsCell)
    func recentsView(recent: UITableViewCell, index: Int, didTapRecentIn cell: RecentsCell)
}

class RecentsCell: UITableViewCell {
    
    weak var delegate: RecentsDelegate?
    var name: String = "Recents Name"
    var cells = [UITableViewCell]()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var viewAllButton: UIButton!
    @IBOutlet var tableView: UITableView!

    static let identifier = Identifiers.RecentsCell
    
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.RecentsCell, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = Sizes.Recents.CornerRadius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(name: String, with cells: [UITableViewCell]) {
        self.name = name
        self.cells = cells
        loadView()
    }
    
    func loadView() {
        self.nameLabel.text = name
        tableView.reloadData()
    }
    
    @IBAction func didTapViewAll(_ sender: UIButton) {
        delegate?.recentsView(didTapViewAllIn: self)
    }
    
    
}

extension RecentsCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cells.count == 0 {
            let emptyLabel = UILabel(frame: tableView.frame)
            emptyLabel.text = "There is no history."
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = .secondaryLabel
            self.tableView.backgroundView = emptyLabel
            return 0
        }
        self.tableView.backgroundView = nil
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        cell.textLabel?.text = "Test"
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            delegate?.recentsView(recent: cell, index: indexPath.row, didTapRecentIn: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
