//
//  User.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 08/06/21.
//

import UIKit

struct UserProfile {
    var name: String
    var photo: UIImage
    
    init(name: String, photo: UIImage? = nil) {
        self.name = name
        self.photo = photo ?? Images.defaultUser
    }
}
