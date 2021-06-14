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
    
    var uiSession: UIViewController? {
        switch name {
        case "Running":
            return RunningTargetViewController()
        default:
            //TODO: tambah target view controller lain
            return RunningTargetViewController()
        }
    }
    
    init(name: String, description: String, image: String) {
        self.name = name
        self.description = description
        self.image = image
    }
}
