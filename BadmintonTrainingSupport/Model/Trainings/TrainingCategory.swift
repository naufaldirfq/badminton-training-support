//
//  TrainingCategory.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 06/06/21.
//

import UIKit

struct TrainingCategory: Codable{
    var name: String
    var trainings: [Training] = []
    
    init(name: String, trainings: [Training]) {
        self.name = name
        self.trainings.append(contentsOf: trainings)
    }
    
}
