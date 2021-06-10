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
        
        tableView.register(NMImageTableViewCell.nib(), forCellReuseIdentifier: NMImageTableViewCell.idetifier)
        tableView.register(TextFieldTableViewCell.nib(), forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        //MARK: Choice Single/Double
        tableView.register(SegmentedCtrlTableViewCell.nib(), forCellReuseIdentifier: SegmentedCtrlTableViewCell.identifier)
        tableView.register(BtnStartMatchTableViewCell.nib(), forCellReuseIdentifier: BtnStartMatchTableViewCell.identifier)
        
    }

}

extension NewMatchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let imgCell = tableView.dequeueReusableCell(withIdentifier: NMImageTableViewCell.idetifier, for: indexPath) as? NMImageTableViewCell{
                //MARK: Configure
                
                imgCell.selectionStyle = .none
                return imgCell
            }
        case 1:
            //MARK: Date
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
        case 5:
            print("Bingo. This is bug hahaha")
        case 6:
            //MARK: Button StartMatch
            if let btnStartCell = tableView.dequeueReusableCell(withIdentifier: BtnStartMatchTableViewCell.identifier, for: indexPath) as? BtnStartMatchTableViewCell{
                //MARK: Configure
                
                return btnStartCell
            }
        default:
            break
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 150
        switch indexPath.row {
        case 0:
            return Sizes.NewMatch.ImageHeight
        case 1...3:
            return Sizes.NewMatch.HeightTextField
        case 4:
            return Sizes.NewMatch.CustomSegmented
            //return UITableView.automaticDimension
        case 5:
            //return Sizes.NewMatch.PlayerType
            return 0
            //need if statement for single/double
        case 6:
            return Sizes.NewMatch.ButtonHeight
        default:
            return 0
        }
    }
    
    
    
}
