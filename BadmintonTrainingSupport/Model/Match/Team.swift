//
//  Team.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 15/06/21.
//

import Foundation

struct Team{
    
    var players: [String]
    var teamScore: [Int]
    
    var playerNames: String {
        var playerNames = ""
        for (index, player) in players.enumerated() {
            if index == 0 {
                playerNames.append(player)
            } else {
                playerNames.append("\n\(player)")
            }
        }
        return playerNames
    }
    
    init(players : [String], teamScore: [Int]) {
        self.players = players
        self.teamScore = teamScore
    }
    
}
