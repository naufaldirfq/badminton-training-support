//
//  Match.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 09/06/21.
//

import UIKit

enum MatchType: String {
    case single = "Single"
    case double = "Double"
}

class Match {
    
    var date = Date()
    var place: String
    var description: String
    
    var type: MatchType
    var teams: [Team]
    var durations: [Int]
  
    var numberOfSets: Int {
        return teams[0].teamScore.count
    }
    
    var durationString: String {
        var totalDuration = 0
        for duration in durations {
            totalDuration += duration
        }
        var hours: Int { return totalDuration / 3600 }
        var minutes: Int { return (totalDuration % 3600) / 60 }
        var seconds: Int { return (totalDuration % 60) }
        var string = ""
        if hours > 0 {
            string.append("\(String(format: "%02d", hours)):")
        }
        string.append("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
        return string
    }
    
    var userMatchWon: Double {
        var matchWon: Double = 0
        for n in 0 ..< numberOfSets {
            if teams[0].teamScore[n] > teams[1].teamScore[n] {
                matchWon += 1
            } else if teams[0].teamScore[n] == teams[1].teamScore[n] {
                matchWon += 0.5
            }
        }
        return matchWon
    }
    
    var matchStatus: NSMutableAttributedString {
        if userMatchWon > Double(numberOfSets)/2{
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.green ]
            return NSMutableAttributedString(string: "W", attributes: myAttribute)
        } else if userMatchWon < Double(numberOfSets)/2  {
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ]
            return NSMutableAttributedString(string: "L", attributes: myAttribute)
        } else {
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
            return NSMutableAttributedString(string: "D", attributes: myAttribute)
        }
    }
    
    init(type: MatchType, with players:[String], place: String? = nil, description: String? = nil){
        teams = []
        durations = []
        self.type = type
        switch type {
        case .single:
            teams.append(Team(players: [players[0]], teamScore: []))
            teams.append(Team(players: [players[1]], teamScore: []))
        case .double:
            teams.append(Team(players: [players[0],players[2]], teamScore: []))
            teams.append(Team(players: [players[1],players[3]], teamScore: []))
        }
        self.place = place ?? ""
        self.description = description ?? ""
    }
}
