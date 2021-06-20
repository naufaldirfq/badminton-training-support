//
//  TrainingSession.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 10/06/21.
//

import Foundation

enum TrainingType : String {
    case Running = "Running"
    case Skipping = "Skipping"
    case PushUp = "Push Up"
    case ShadowBadminton = "Shadow Badminton"
    case WallRally = "Wall Rally"
    case Swing = "Swing"
}

struct TrainingSession {
    var name: String
    var date: Date
    var time: Int
    var pace: Int
    var distance: Int
    var set: Int
    var repetition: Int
    var breakTime: Int


    init(name : String, date: Date, time: Int, pace: Int = 0, distance: Int = 0, set: Int = 0, repetition: Int = 0, breakTime: Int = 0) {
        self.name = name
        self.date = date
        self.time = time
        self.pace = pace
        self.distance = distance
        self.set = set
        self.repetition = repetition
        self.breakTime = breakTime
    }
    
    func getDateRelativity() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: self.date, relativeTo: Date())
        
        
        return relativeDate
    }
   
     func daysCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date ).day ?? 0
     }
     // Returns the number of hours
     func hoursCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date).hour ?? 0
     }

     // Returns time ago by checking if the time differences between two dates are in year or months or weeks or days or hours or minutes or seconds


}
