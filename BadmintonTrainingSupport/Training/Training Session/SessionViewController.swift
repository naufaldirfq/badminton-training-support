//
//  SessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 21/06/21.
//

import UIKit

class SessionViewController: UIViewController {

    var trainingSession: TrainingSession?
    weak var delegate: TrainingSessionViewController?
    
    var timer: Timer?
    var isPaused = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func timeToString(_ time: Int) -> String{
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        var string = ""
        if hours > 0 {
            string.append("\(String(format: "%02d", hours)):")
        }
        string.append("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
        return string
    }
    
    func toggleTime() {
        if isPaused {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        } else {
            timer?.invalidate()
        }
        isPaused = !isPaused
    }
    
    @objc func timerCounter() {
        
    }
    
    func finishSession() {
        if let session = trainingSession {
            FirestoreReferenceManager.db.collection("training_history").addDocument(data: [
                "date": session.date,
                "time": session.time,
                "distance": session.distance,
                "pace": session.pace,
                "name": session.name,
                "breakTime": session.breakTime,
                "set": session.set,
                "repetition": session.repetition,
                "user": UserDefaults.standard.string(forKey: K.userID)!
            ])
            Local.data.trainingHistory.append(session)
        }
    }
    
    func setSummary() {
        
    }
}

extension SessionViewController: TrainingSessionDelegate {
    func didTapPlayButton() {
        toggleTime()
    }
    
    func didTapStopButton() {
        finishSession()
    }
    
    func didTapPauseButton() {
        toggleTime()
    }
    func setupSummaryView() {
        setSummary()
    }
}
