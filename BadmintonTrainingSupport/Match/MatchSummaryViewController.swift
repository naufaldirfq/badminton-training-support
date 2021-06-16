//
//  MatchSummaryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchSummaryViewController: UIViewController, FinishMatchCellTapped {
    func tapFinishButton() {
        //fungsi ke halaman berikutnya
    }
    
    let match = DummyData.MatchHistory[0]
    @IBOutlet weak var matchSummaryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        matchSummaryTableView.delegate = self
        matchSummaryTableView.dataSource = self
        matchSummaryTableView.register(NMImageTableViewCell.nib(), forCellReuseIdentifier: NMImageTableViewCell.identifier)
        matchSummaryTableView.register(SummaryMainInfoTableViewCell.nib(), forCellReuseIdentifier: SummaryMainInfoTableViewCell.identifier)
        matchSummaryTableView.register(ScoreTableCell.nib(), forCellReuseIdentifier: ScoreTableCell.identifier)
        matchSummaryTableView.register(FinishMatchCell.nib(), forCellReuseIdentifier: FinishMatchCell.identifier)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MatchSummaryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                if let imgCell = tableView.dequeueReusableCell(withIdentifier: NMImageTableViewCell.identifier, for:  indexPath) as? NMImageTableViewCell{
                

                return imgCell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as? SummaryMainInfoTableViewCell{
                    cell.configureCell(leftInfo: "10/04/2000" , leftTitle: "Date", rightInfo: "Anok", rightTitle: "Place")
                    return cell
                }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as? SummaryMainInfoTableViewCell{
                cell.configureCell(leftInfo: "Double", leftTitle: "Match Type", rightInfo: "Disini", rightTitle: "Match Description")
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableCell.identifier, for: indexPath) as? ScoreTableCell{
                cell.configure(match: match)
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as? SummaryMainInfoTableViewCell{
                cell.configureCell(leftInfo: "", leftTitle: "Match Duration")
                return cell
            }
        case 5: if let cell = tableView.dequeueReusableCell(withIdentifier: FinishMatchCell.identifier, for: indexPath) as? FinishMatchCell{
            cell.delegate = self
//            cell.configure() //set disini untuk menentukan dia hidden ato ga
        }
            
        default: break
            
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
            case 5:
                return Sizes.MatchSummary.FinishButton
            default:
                return UITableView.automaticDimension
            }
        }
    
    
    
    
    
    
    
}
