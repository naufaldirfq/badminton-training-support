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
        
        tableView.register(NMImageTableViewCell.nib(), forCellReuseIdentifier: NMImageTableViewCell.identifier)
        tableView.register(TextFieldTableViewCell.nib(), forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        //MARK: Choice Single/Double
        tableView.register(SegmentedCtrlTableViewCell.nib(), forCellReuseIdentifier: SegmentedCtrlTableViewCell.identifier)
        
    }

}

extension NewMatchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let imgCell = tableView.dequeueReusableCell(withIdentifier: NMImageTableViewCell.identifier, for: indexPath) as? NMImageTableViewCell{
                //MARK: Configure
                
                imgCell.selectionStyle = .none
                return imgCell
            }
        case 1:
            //MARK: Date
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let currentDate = formatter.string(from: date)

                fieldCell.configure(with: "Date:", placeholderTemp: currentDate)
                //Buat validasi jika user menggunakan inputan placeholder
                fieldCell.configureDate(with: currentDate)

                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 2:
            //MARK: Place
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                //fieldCell.configure(with: "Place")
                fieldCell.configure(with: "Place:", placeholderTemp: "Jakarta, Indonesia")
                
                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 3:
            //MARK: Match Description
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                fieldCell.configure(with: "Match Description:", placeholderTemp: "Training Session 1")
                
                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 4:
            //MARK: Segmented Control (Match Type)
            if let choiceCell = tableView.dequeueReusableCell(withIdentifier: SegmentedCtrlTableViewCell.identifier, for: indexPath) as? SegmentedCtrlTableViewCell{
                
                choiceCell.selectionStyle = .none
                return choiceCell
            }
        default:
            break
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return Sizes.NewMatch.ImageHeight
        case 1...3:
            return Sizes.NewMatch.HeightTextField
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    
}
