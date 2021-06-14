//
//  Training.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

struct Training {
    let name: String
    let description: String
    let image: UIImage
    let sessionVC: UIViewController
    
    init(name: String, description: String, image: UIImage? = nil, sessionVC: UIViewController? = nil) {
        self.name = name
        self.description = description
        self.image = image ?? Images.defaultTraining
        self.sessionVC = sessionVC ?? TrainingSessionViewController()
    }
}
