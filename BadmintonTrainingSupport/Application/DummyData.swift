//
//  DummyData.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

struct DummyData {
   
    static let Trainings = [
        Training(name: "Running", description: "Pros run 2 km every day"),
        Training(name: "Skipping", description: "Pros skip 1000 times every day"),
        Training(name: "Push Up", description: "Pros push up 100 times every day"),
        Training(name: "Multi Shuttle", description: "Pros hit 1000 shuttles every day"),
        Training(name: "Shadow Badminton", description: "Pros do 30 minutes of shadow badminton every day"),
        Training(name: "Serve", description: "Pros serve 100 shuttle every day")
    ]
    
    static let PhysicalTrainings = [
        Training(name: "Running", description: "Pros run 2 km every day"),
        Training(name: "Skipping", description: "Pros skip 1000 times every day"),
        Training(name: "Push Up", description: "Pros push up 100 times every day")
    ]
    
    static let TechnicalTrainings = [
        Training(name: "Multi Shuttle", description: "Pros hit 1000 shuttles every day"),
        Training(name: "Shadow Badminton", description: "Pros do 30 minutes of shadow badminton every day"),
        Training(name: "Serve", description: "Pros serve 100 shuttle every day")
    ]
    
    static let MatchHistory = [
        Match(player1: "you", player2: "ganteng", player3: "jelek", player4: "jago", matchSet: 2, teamScoreA: [21,21], teamScoreB: [0,0]),
        Match(player1: "you", player2: "xiix", player3: "xuxu", player4: "xaxa", matchSet: 3, teamScoreA: [19,21,0], teamScoreB: [21,0,21]),
        Match(player1: "you", player2: "hehe", player3: "huhu", player4: "haha", matchSet: 2, teamScoreA: [19,21], teamScoreB: [21,0])
        
    ]
    
    static let TrainingHistory = [TrainingSession(trainingName: "Larii", trainingDate: Date().addingTimeInterval(-15000)
, trainingResult: ["1 Km","20 min"], trainingMeasurement: ["Jarak","waktu"]),
                                  TrainingSession(trainingName: "Larii", trainingDate: Date().addingTimeInterval(-17000), trainingResult: ["1 m/s","2 Sets"], trainingMeasurement: ["Laju","Reps"]),
                                  TrainingSession(trainingName: "Larii", trainingDate: Date().addingTimeInterval(-20000), trainingResult: ["1 m/s","2 kilo"], trainingMeasurement: ["Laju","Jarak"])]
    
    static let Physical = TrainingCategory(name: "Physical", trainings: PhysicalTrainings)
    static let Technical = TrainingCategory(name: "Technical", trainings: TechnicalTrainings)
    
    static let Categories = [Physical, Technical]
    
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
