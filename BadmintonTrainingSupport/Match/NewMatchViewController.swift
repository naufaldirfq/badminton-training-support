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
        switch indexPath.row {
        case 0:
            print("test ...")
        case 1:
/*
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecentsCell.identifier) as? RecentsCell {
                cell.configure(name: "Recent Trainings", with: DummyData.TrainingCell())
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
 */
            
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                fieldCell.configure(with: "Date")
                
                fieldCell.selectionStyle = .none
                return fieldCell
            }
            
        case 2:
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                fieldCell.configure(with: "Place")
                
                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 3:
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                fieldCell.configure(with: "Match Description")
                
                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 4:
            //MARK: Segmented Control (Match Type)
            print("Ini Match Type Segmented Control")
        case 5:
            if let mtSingleCell = tableView.dequeueReusableCell(withIdentifier: MTSingleTableViewCell.identifier, for: indexPath) as? MTSingleTableViewCell {
                //MARK: Configure
                mtSingleCell.configure(with: "Player")
                
                mtSingleCell.selectionStyle = .none
                return mtSingleCell
            }
        case 6:
            //MARK: Segmented Control (Match Type)
            print("Ini Match Type Segmented Control")
            
        default:
            break
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
//        func nmInputLabel(){
//            return 30
//        }
    }
    
    
    
}
