//
//  RunningSessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 14/06/21.
//

import UIKit

class RunningSessionViewController: SessionViewController {

    @IBOutlet weak var mainMeasurementLabel: UILabel!
    @IBOutlet weak var mainUnitLabel: UILabel!
    @IBOutlet weak var mainCounterLabel: UILabel!
    @IBOutlet weak var leftMeasurementLabel: UILabel!
    @IBOutlet weak var leftCounterLabel: UILabel!
    @IBOutlet weak var rightMeasurementLabel: UILabel!
    @IBOutlet weak var rightCounterLabel: UILabel!
    
    var totalTime = 0 {
        didSet {
            self.rightCounterLabel.text = timeToString(totalTime)
            self.leftCounterLabel.text = timeToString(pace)
            self.mainCounterLabel.text = "\(distance)"
        }
    }
    var distance: Double = 0
    var pace: Int {
        return distance == 0 ? Int(distance) : Int(Double(totalTime) / distance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let session = trainingSession {
            totalTime = Int(session.time) * 60
        }
    }
    
    @objc override func timerCounter() {
        if totalTime > 0 {
            totalTime -= 1
        } else {
            delegate?.toggleButton()
            timer?.invalidate()
            isPaused = !isPaused
        }
    }
}
