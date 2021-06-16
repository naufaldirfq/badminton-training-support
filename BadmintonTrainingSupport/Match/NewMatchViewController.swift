//
//  NewMatchViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

enum MatchFormTextField {
    case date
    case place
    case description
    case playerA1
    case playerA2
    case playerB1
    case playerB2
}

struct MatchForm {
    var place: String = ""
    var description: String = ""
    var type: MatchType = .single
    var players = [DummyData.Profile.name,"","",""]
    var isValid: Bool {
        switch type {
        case .single:
            for player in players[0...1] {
                if player == "" {
                    return false
                }
            }
        case .double:
            for player in players[0...3] {
                if player == "" {
                    return false
                }
            }
        }
        return true
    }
}

class NewMatchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var form = MatchForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Match"
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
                let currentDate = Formatter.date.string(from: date)

                fieldCell.configure(with: "Date:", for: .date , placeholderTemp: currentDate, readonly: true)
                //Buat validasi jika user menggunakan inputan placeholder
                fieldCell.configureDate(with: currentDate)
                fieldCell.delegate = self
                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 2:
            //MARK: Place
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                //fieldCell.configure(with: "Place")
                fieldCell.configure(with: "Place:", for: .place)
                fieldCell.delegate = self
                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 3:
            //MARK: Match Description
            if let fieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell {
                //MARK: Configure
                fieldCell.configure(with: "Match Description:", for: .description)
                fieldCell.delegate = self
                fieldCell.selectionStyle = .none
                return fieldCell
            }
        case 4:
            //MARK: Segmented Control (Match Type)
            if let choiceCell = tableView.dequeueReusableCell(withIdentifier: SegmentedCtrlTableViewCell.identifier, for: indexPath) as? SegmentedCtrlTableViewCell{
                choiceCell.delegate = self
                choiceCell.selectionStyle = .none
                return choiceCell
            }
        default:
            break
        }
        return UITableViewCell()
        
    }
}

extension NewMatchViewController: SegmentedCtrlDelegate {
    func segmentedCtrl(with text: String, didFinishEditingFor textField: MatchFormTextField) {
        switch textField {
        case .playerA1:
            form.players[0] = text
        case .playerA2:
            form.players[2] = text
        case .playerB1:
            form.players[1] = text
        case .playerB2:
            form.players[3] = text
        default:
            break
        }
    }
    
    func singleMatch(with match: Match) {
        form.type = .single
        if form.isValid {
            var match = Match(type: .single, with: Array(form.players[0...1]))
            match.place = form.place
            match.description = form.description
            let vc = MatchSessionViewController()
            vc.match = match
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("nope, empty")
        }
    }
    
    func doubleMatch(with match: Match) {
        form.type = .double
        if form.isValid {
            let match = Match(type: .double, with: Array(form.players[0...3]))
            let vc = MatchSessionViewController()
            vc.match = match
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("nope, empty")
        }
    }
}

extension NewMatchViewController: TextFieldCellDelegate {
    func textField(with text: String, didFinishEditingFor textField: MatchFormTextField) {
        switch textField {
        case .place:
            form.place = text
        case .description:
            form.description = text
        default:
            break
        }
    }
}
