//
//  MatchSessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchSessionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MatchSessionTableViewCell.nib(), forCellReuseIdentifier: MatchSessionTableViewCell.identifier)
    }


}

extension MatchSessionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MatchSessionTableViewCell.identifier, for: indexPath) as? MatchSessionTableViewCell{
            //MARK: Configure
            cell.configure(with: DummyData.MatchHistory[indexPath.row])
            
        
            
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return Sizes.MatchSession.Height
    }
    
}
