//
//  DummyData.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

struct DummyData {
    
    static let Trainings = [
        Training(name: "Running", description: "Pros run 2 km every day", image: ""),
        Training(name: "Skipping", description: "Pros skip 1000 times every day", image: ""),
        Training(name: "Push Up", description: "Pros push up 100 times every day", image: ""),
        Training(name: "Multi Shuttle", description: "Pros hit 1000 shuttles every day", image: ""),
        Training(name: "Shadow Badminton", description: "Pros do 30 minutes of shadow badminton every day", image: ""),
        Training(name: "Serve", description: "Pros serve 100 shuttle every day", image: "")
    ]
    static var history = DummyData()
    init() {
        
        var match = Match(type: .double, with: ["Hanif Fauzi","Kevin Leon","Joanda Febrian","Naufal Athallah"])
        match.date = Date().addingTimeInterval(-90000)
        match.teams[0].teamScore = [14,21,21]
        match.teams[1].teamScore = [21,16,19]
        match.durations = [1200,1200,1200]
        dummyMatches.append(match)
        match = Match(type: .double, with: ["Hanif Fauzi","Kevin Leon","Dhika Aditya","Adhesya Pratama"])
        match.date = Date().addingTimeInterval(-16000)
        match.teams[0].teamScore = [16,20]
        match.teams[1].teamScore = [21,22]
        match.durations = [1200,1200]
        dummyMatches.append(match)
        match = Match(type: .single, with: ["Hanif Fauzi","Kevin Leon"])
        match.date = Date()
        match.teams[0].teamScore = [10,21]
        match.teams[1].teamScore = [21,13]
        match.durations = [1200,1200]
        dummyMatches.append(match)
        TrainingHistory.append(contentsOf: [
        TrainingSession(trainingName: "Skipping", trainingDate: Date().addingTimeInterval(-17000), trainingResult: ["6","80 sec"], trainingMeasurement: ["Sets","Duration"]),
        TrainingSession(trainingName: "Wall Rally", trainingDate: Date().addingTimeInterval(-16000), trainingResult: ["5","3 min"], trainingMeasurement: ["Sets","Duration"]),
        TrainingSession(trainingName: "Running", trainingDate: Date().addingTimeInterval(-15000), trainingResult: ["4 km","20 min"], trainingMeasurement: ["Distance","Time"])
        ])
        
    }
    var dummyMatches: [Match] = []
    
    var TrainingHistory : [TrainingSession] = []
    
    static let Profile = UserProfile(name: "Hanif Fauzi", photo: UIImage(named: "hanif")!)
    
    struct Recent {
        static let Trainings: [Training] = [
            
        ]
    }
    
    static func TrainingCell() -> [UITableViewCell] {
        let cells = [
            UITableViewCell(),
            UITableViewCell(),
            UITableViewCell()
        ]
        return cells
    }
    
    
}
