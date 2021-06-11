//
//  Match.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 09/06/21.
//

import UIKit
struct Match {
    var player1: String
    var player2: String
    var player3: String
    var player4: String
    var matchSet: Int
    var teamScoreA: [Int]
    var teamScoreB: [Int]
    
    init(player1: String, player2: String, player3: String, player4: String, matchSet: Int, teamScoreA:[Int], teamScoreB:[Int]) {
        self.player1 = player1
        self.player2 = player2
        self.player3 = player3
        self.player4 = player4
        self.matchSet = matchSet
        self.teamScoreA = teamScoreA
        self.teamScoreB = teamScoreB
    }
    func getEachMatchStatus() -> [Int] {
        var matchStatus: [Int] = []
        for n in 0..<matchSet {
            if teamScoreA[n] > teamScoreB[n] {
                matchStatus.append(1)
            }else{
                matchStatus.append(0)
            }
        }
        return matchStatus
    }
    func getOverallMatchStatus() -> NSMutableAttributedString {
        let matchStatus = getEachMatchStatus()
        var totalMatch = 0.0
        for n in 0..<matchSet {
            totalMatch = totalMatch + Double(matchStatus[n])
        }
        if  totalMatch > Double(matchSet)/2{
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.green ]
            return NSMutableAttributedString(string: "W", attributes: myAttribute)
        }else{
            if totalMatch < Double(matchSet)/2  {
                let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ]
                return NSMutableAttributedString(string: "L", attributes: myAttribute)
            }else{
                let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
                return NSMutableAttributedString(string: "D", attributes: myAttribute)
            }
        }
    }
}
