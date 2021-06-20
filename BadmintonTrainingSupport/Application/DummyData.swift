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
    
    static var dummyMatches: [Match] {
        var matches: [Match] = []
        for _ in 1...3 {
            let match = Match(type: .double, with: ["Joanda Febrian","Kevin Leon","Hanif Fauzi","Naufal Athallah"])
            match.date = Date()
            match.teams[0].teamScore = [14,16,21]
            match.teams[1].teamScore = [21,21,19]
            match.durations = [1200,1200,1200]
            matches.append(match)
        }
        return matches
    }
    
    static let TrainingHistory = [TrainingSession(trainingName: "Larii", trainingDate: Date().addingTimeInterval(-15000)
, trainingResult: ["1 Km","20 min"], trainingMeasurement: ["Jarak","waktu"]),
                                  TrainingSession(trainingName: "Larii", trainingDate: Date().addingTimeInterval(-17000), trainingResult: ["1 m/s","2 Sets"], trainingMeasurement: ["Laju","Reps"]),
                                  TrainingSession(trainingName: "Larii", trainingDate: Date().addingTimeInterval(-20000), trainingResult: ["1 m/s","2 kilo"], trainingMeasurement: ["Laju","Jarak"])]
    
    static let Profile = UserProfile(name: "Hanif Fauzi")
    
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
