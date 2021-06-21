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
    var categories: [TrainingCategory] = []
    var trainings: [Training] {
        var trainingsList = [Training]()
        for category in categories {
            for training in category.trainings {
                trainingsList.append(training)
            }
        }
        return trainingsList
    }
    
    var trainingsWithValidData: [Training] {
        for training in trainings {
            if training.name == "Running" {
                return [training]
            }
        }
        return []
    }
}
