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
    @IBOutlet weak var chartLabel: UILabel!
    @IBOutlet weak var trainingChart: BarChartView!
    var ydata: [Double] = []
    var xdata: [String] = [] {
        didSet {
            trainingChart.xAxis.labelCount = xdata.count
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        axisformatDelegate = self
        selectionStyle = .none
        trainingChart.xAxis.drawGridLinesEnabled = false
        trainingChart.setVisibleXRangeMaximum(7)
        trainingChart.rightAxis.enabled = false
        trainingChart.xAxis.labelPosition = .bottom
        trainingChart.leftAxis.drawGridLinesEnabled = false
        trainingChart.isUserInteractionEnabled = false
        
//        trainingChart.leftAxis.setLabelCount(Int(7/interval) + 1, force: true)
    }
    
    func configure(with training: Training) {
        chartLabel.text = training.name
        for localTraining in Local.data.trainingHistory {
            if training.name == localTraining.name {
                xdata.append(Formatter.shortDate.string(from: localTraining.date))
                switch localTraining.name {
                case "Running":
                    ydata.append(localTraining.speed)
                default:
                    break
                }
            }
        }
        setChart(dataEntryX: xdata, dataEntryY: ydata, with: "m/s")
    }
    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double], with unit: String) {
        trainingChart.noDataText = "You need to provide data for the chart."
        var dataEntries:[BarChartDataEntry] = []
        for i in 0..<forY.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: forX as AnyObject?)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: unit)
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
        print(value)
        return xdata[Int(value)]
    }
}

