//
//  Constants.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

struct Identifiers {
    static let TrainingCollectionCell = "TrainingCollectionCell"
    static let TrainingCell = "TrainingCell"
    static let RecentsCell = "RecentsCell"

    static let TrainingHistoryCell = "TrainingHistoryTableViewCell"
    static let MatchHistoryCell = "MatchHistoryCell"
    static let HomeProfileCell = "HomeProfileCell"
    static let SummaryMainInfoCell = "SummaryMainInfoTableViewCell"
    static let ScoreTabelCell = "ScoreTableCell"
    static let ScoreCell = "ScoreCell"
    static let FinishMatchCell = "FinishMatchCell"
}

struct Formatter {
    static var date: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter
    }
}

struct K {
    static let userID = "UserID"
    static let UserName = "UserName"
    static let PhotoURL = "PhotoURL"
}

struct Images {
    static let defaultTraining = UIImage(systemName: "photo")!
    static let defaultUser = UIImage(systemName: "person.circle")!
}

struct Colors {
    static let AccentColor = UIColor(named: "AccentColor")!
}

struct MSstore {
    static let Set = "0"
    static let Time = "00/00/00"
    static let ScoreTeammate = "0"
    static let ScoreOpponent = "0"
}

extension UserDefaults {

    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

}
