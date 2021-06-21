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
        static let CellHeight: CGFloat = 72
        static let TableMargins: CGFloat = 52.5 + 16
        static let CornerRadius: CGFloat = 10.0
    }
    struct HomeProfile {
        static let Height: CGFloat = 82.0
        static let ProfileInfoHeight: CGFloat = 130
        static let ChartsHeight: CGFloat = 360
    }
    
    //MARK: Size for page "NewMatchVC"
    struct NewMatch {
        static let ImageHeight: CGFloat = 128
        static let HeightTextField: CGFloat = 52 + (8*3) + 16
        static let PlayerType: CGFloat = 380
        static let ButtonHeight: CGFloat = HeightTextField - 10
        static let CornerRadius: CGFloat = 10.0
    }
    
    struct  MatchSession {
        static let Height: CGFloat = 666
    }
    
    struct MatchSummary{
        static let ImageHeight: CGFloat = 140
        static let SummaryInfo: CGFloat = 80 //def: 80
        static let ScoreTable: CGFloat = 154
        static let FinishButton: CGFloat = 52

    }
}
