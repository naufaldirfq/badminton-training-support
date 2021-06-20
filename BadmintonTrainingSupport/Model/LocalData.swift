//
//  LocalData.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 21/06/21.
//

import Foundation

struct Local {
    static var data = Local()
    var matchHistory: [Match] = []
    var trainingHistory: [TrainingSession] = []
}
