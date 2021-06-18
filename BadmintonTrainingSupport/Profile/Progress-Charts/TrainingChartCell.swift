//
//  TrainingChartCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 18/06/21.
//

import UIKit
import Charts
class TrainingChartCell: UITableViewCell {

    @IBOutlet weak var trainingChart: BarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        var dataentry = [BarChartDataEntry]()
        for x in 0..<10 {
            dataentry.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        
        let set = BarChartDataSet(entries: dataentry)
        let data = BarChartData(dataSet: set)
        trainingChart.data = data
        // Initialization code
    }
    static let identifier = "TrainingChartCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
