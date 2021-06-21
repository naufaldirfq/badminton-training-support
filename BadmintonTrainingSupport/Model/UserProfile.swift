//
//  User.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 08/06/21.
//

import UIKit
import Firebase

struct UserProfile {
    static var uid: String {
        return UserDefaults.standard.string(forKey: K.userID)!
    }
    
    static var name: String {
        if !UserDefaults.exists(key: K.UserName) {
            UserDefaults.standard.setValue("Player", forKey: K.UserName)
        }
        return UserDefaults.standard.string(forKey: K.UserName)!
    }
    
    static var photo: UIImage {
        if UserDefaults.exists(key: K.PhotoURL) {
            guard let photoURL = UserDefaults.standard.string(forKey: K.PhotoURL) else { return Images.defaultUser }
            guard let url = URL(string: photoURL) else { return Images.defaultUser }
            let data = try? Data(contentsOf: url)

            if let imageData = data {
                if let image = UIImage(data: imageData) {
                    return image
                }
            }
        }
        return Images.defaultUser
    }
}
