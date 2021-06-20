//
//  TrainingChartCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 18/06/21.
//

import UIKit
import Charts
class TrainingChartCell: UITableViewCell {
    var trainingUnit : String = ""
    weak var axisformatDelegate: IAxisValueFormatter?
    @IBOutlet weak var trainingChart: BarChartView!
    var ydummy: [Double] = [0,1,2,3,4,5,6]
    var xdummy = ["a","b","a","b","a","b","a"]
    override func awakeFromNib() {
        super.awakeFromNib()
        axisformatDelegate = self
        
        setChart(dataEntryX: xdummy, dataEntryY: ydummy)
        selectionStyle = .none
        trainingChart.xAxis.drawGridLinesEnabled = false
        
        trainingChart.rightAxis.enabled = false
//        trainingChart.legend.enabled = true

        trainingChart.xAxis.labelPosition = .bottom
        trainingChart.leftAxis.drawGridLinesEnabled = false
//        trainingChart.leftAxis.valueFormatter = YAxisValueFormatter()
        trainingChart.isUserInteractionEnabled = false
    }
//    func configure(with trainings: [TrainingSession]) {
//        switch trainings[0]. {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {
            trainingChart.noDataText = "You need to provide data for the chart."
            var dataEntries:[BarChartDataEntry] = []
            for i in 0..<forX.count{
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: xdummy as AnyObject?)
                print(dataEntry)
                dataEntries.append(dataEntry)
            }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: trainingUnit)
        let chartData = BarChartData(dataSet: chartDataSet)
        let xAxisValue = trainingChart.xAxis
        trainingChart.data = chartData
            
            xAxisValue.valueFormatter = axisformatDelegate

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
extension TrainingChartCell: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return xdummy[Int(value)]
    }
}
//class YAxisValueFormatter: NSObject, IAxisValueFormatter {
//
//    let numFormatter: NumberFormatter
//
//    override init() {
//        numFormatter = NumberFormatter()
//        numFormatter.minimumFractionDigits = 1
//        numFormatter.maximumFractionDigits = 1
//        numFormatter.minimumIntegerDigits = 1
//        numFormatter.paddingPosition = .afterSuffix
//        numFormatter.paddingCharacter = "m/s"
//        numFormatter.paddin
//    }
//
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return numFormatter.string(from: NSNumber(floatLiteral: value))!
//    }
//}

