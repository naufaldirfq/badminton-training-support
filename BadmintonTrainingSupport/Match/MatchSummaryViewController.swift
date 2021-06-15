//
//  MatchSummaryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchSummaryViewController: UIViewController {
    
    @IBOutlet weak var matchSummaryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        matchSummaryTableView.delegate = self
        matchSummaryTableView.dataSource = self
        matchSummaryTableView.register(NMImageTableViewCell.nib(), forCellReuseIdentifier: NMImageTableViewCell.identifier)
        matchSummaryTableView.register(SummaryMainInfoTableViewCell.nib(), forCellReuseIdentifier: SummaryMainInfoTableViewCell.identifier)
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                if let imgCell = tableView.dequ(withIdentifier: NMImageTableViewCell.identifier, for:  indexPath) as! NMImageTableViewCell{
                //MARK: Configure
                

                return imgCell
                }
            case 1:
                if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as! SummaryMainInfoTableViewCell{
                    cell.configureCell(leftInfo: "Date", leftTitle: String(""), rightInfo: "Place", rightTitle: "")
                    return cell
                }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMainInfoTableViewCell.identifier, for: indexPath) as? SummaryMainInfoTableViewCell{
                cell.configureCell(leftInfo: <#T##String#>, leftTitle: <#T##String#>, rightInfo: <#T##String#>, rightTitle: <#T##String#>)
                return cell
            }
        case 3:
            
        
        default:
            <#code#>
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
