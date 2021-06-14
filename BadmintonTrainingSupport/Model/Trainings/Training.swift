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
    let targetVC: UIViewController?
    
    init(name: String, description: String, image: UIImage? = nil, targetVC: UIViewController? = nil, sessionVC: UIViewController? = nil) {
        self.name = name
        self.description = description
        self.image = image ?? Images.defaultTraining
        self.targetVC = targetVC
        self.sessionVC = sessionVC ?? TrainingSessionViewController()
    }
}
