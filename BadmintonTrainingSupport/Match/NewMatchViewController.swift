//
//  NewMatchViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class NewMatchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(TextFieldTableViewCell.nib(), forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        tableView.register(MTSingleTableViewCell.nib(), forCellReuseIdentifier: MTSingleTableViewCell.identifier)
    }

}

extension NewMatchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 /*
        if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
        
            return fieldCell
        }
        
        if let mtSingleCell = tableView.dequeueReusableCell(withIdentifier: MTSingleTableViewCell.identifier, for: indexPath) as? MTSingleTableViewCell {
        
            return mtSingleCell
        }
 */
        
        if indexPath.row > 2 {
            print("ini gambar")
        }
        if indexPath.row > 5 {
            let fieldCell = (tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell)!
            
            return fieldCell

        }
        
        if indexPath.row > 7 {
            print("ini segmented control")
        }
        
 //MARK: Penanda Switch
        if let mtSingleCell = tableView.dequeueReusableCell(withIdentifier: MTSingleTableViewCell.identifier, for: indexPath) as? MTSingleTableViewCell {
        
            return mtSingleCell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
}
