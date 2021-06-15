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
    init(players : [String], teamScore: [Int]) {
        self.players = players
        self.teamScore = teamScore
    }
    
}
