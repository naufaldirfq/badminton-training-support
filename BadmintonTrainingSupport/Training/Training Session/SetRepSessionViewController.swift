//
//  SetRepSessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 21/06/21.
//

import UIKit

class SetRepSessionViewController: SessionViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var secondStatusLabel: UILabel!
    @IBOutlet weak var setsLeftLabel: UILabel!
    
    var onBreak = false {
        didSet {
            guard let session = trainingSession else { return }
            setsLeft -= onBreak ? 0 : 1
            currentTime = onBreak ? session.breakTime : session.repetition
            statusLabel.text = onBreak ? "BREAK" : "SET \(currentSet)"
        }
    }
    
    var setsLeft = 0 {
        didSet {
            setsLeftLabel.text = "\(setsLeft)"
        }
    }
    
    var currentSet: Int {
        if let session = trainingSession {
            return session.set - setsLeft
        }
        return 0
    }
    
    var currentTime = 0 {
        didSet {
            timerLabel.text = timeToString(currentTime)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let session = trainingSession {
            setsLeft = session.set - 1
            currentTime = session.repetition
        }
    }
    
    @objc override func timerCounter() {
        if currentTime > 0 {
            currentTime -= 1
        } else {
            if setsLeft < 1 {
                delegate?.toggleButton()
                timer?.invalidate()
                isPaused = !isPaused
                statusLabel.text = ""
            } else {
                onBreak = !onBreak
            }
        }
    }
    
    override func setSummary() {
        guard let session = trainingSession else { return }
        statusLabel.text = "\(session.set) SETS"
        timerLabel.text = timeToString(session.repetition)
        secondStatusLabel.text = "REST INTERVAL"
        setsLeftLabel.text = timeToString(session.breakTime)
    }
}

