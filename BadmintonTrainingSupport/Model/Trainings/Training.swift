//
//  Training.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

struct Training: Codable {
    var name: String
    var description: String
    var image: String
    
    var uiImage: UIImage? {
        return UIImage(named: image)
    }
    
//    var trainings: [TrainingSession] {
//        var temp: [TrainingSession] = []
//        for session in Local.data.trainingHistory {
//            if session.name == name {
//
//            }
//        }
//    }
    
    var uiTarget: UIViewController? {
        switch name {
        case "Running":
            return RunningTargetViewController(nibName: "RunningTargetViewController", bundle: nil)
        default:
            return SetRepTargetViewController(nibName: "SetRepTargetViewController", bundle: nil)
        }
    }
    
    var uiSession: UIViewController? {
        switch name {
        case "Running":
            return RunningSessionViewController(nibName: "RunningSessionViewController", bundle: nil)
        default:
            return SetRepSessionViewController(nibName: "SetRepSessionViewController", bundle: nil)
        }
    }
    
    init(name: String, description: String, image: String) {
        self.name = name
        self.description = description
        self.image = image
    }
}
