//
//  RecentsCell.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class RecentsCell: UITableViewCell {
    
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
        self.cells.append(contentsOf: cells)
        loadView()
    }
    
    func loadView() {
        self.nameLabel.text = name
        tableView.reloadData()
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
        return cell
    }
    
}
