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
    
    init(name: String, description: String, image: UIImage? = nil) {
        self.name = name
        self.description = description
        self.image = image ?? UIImage(systemName: "photo.fill")!
    }
}
