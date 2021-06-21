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
            print("dist :" + String(distance))
            print("pace :" + String(pace))
            self.rightCounterLabel.text = timeToString(totalTime)
            self.leftCounterLabel.text = timeToString(pace)
            self.mainCounterLabel.text = String(format: "%.2f", distance / 1000)
        }
    }
    var distance: Double = 0
    var pace: Int {
        if let time = trainingSession?.time {
            
            return distance == 0 ? Int(Double(time * 60 - totalTime)) : Int(Double( time * 60 - totalTime) / (distance / 1000.0))
        }
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let session = trainingSession {
            totalTime = Int(session.time) * 60
            
            distance = Double(session.distance)
            rightCounterLabel.text = timeToString(totalTime)
            mainCounterLabel.text = "\(String(format: "%.2f", session.distanceInKM))"
            leftCounterLabel.text = timeToString(session.pace)
        }
    }
    override func finishSession() {
        let time = trainingSession!.time * 60
        trainingSession?.distance = Int(distance)
        trainingSession?.pace = Int(Double( time ) / (distance / 1000.0))
        super.finishSession()
        
    }
    @objc override func timerCounter() {
        if totalTime > 0 {
            distance += 2.7
            totalTime -= 1
            
            
            if totalTime == 1200 - 4 {
                distance = (1200.0 - 4.0) * 2.7
                totalTime = 3
                
            }
        } else {
            delegate?.toggleButton()
            timer?.invalidate()
            isPaused = !isPaused
        }
    }
}
