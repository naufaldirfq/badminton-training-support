//
//  Sizes.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

struct Sizes {
    struct TrainingCollection {
        static let CellHeight: CGFloat = 242.0
        static let Height: CGFloat = 52.5 + CellHeight
        static let CornerRadius: CGFloat = 10.0
        static let DefaultWidth: CGFloat = 280.0
        static let EdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    struct Recents {
        static let TableHeight: CGFloat = 200.0
        static let CellHeight: CGFloat = 60.0
        static let Height: CGFloat = 52.5 + TableHeight + 16
        static let CornerRadius: CGFloat = 10.0
    }
    
    //MARK: Size for page "NewMatchVC"
    struct NewMatch {
        static let ImageHeight: CGFloat = 140 //def: 139
        static let HeightTextField: CGFloat = 82 //def: 80
        //static let PlayerType: CGFloat = 180
        
        static let CustomSegmented: CGFloat = 410
        static let PlayerType: CGFloat = 380
        
        static let ButtonHeight: CGFloat = HeightTextField - 10
        static let CornerRadius: CGFloat = 10.0
    }
}
