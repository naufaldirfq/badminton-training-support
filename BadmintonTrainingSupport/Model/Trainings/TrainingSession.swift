//
//  TrainingSession.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 10/06/21.
//

import Foundation
struct TrainingSession {
    var trainingName: String
    var trainingDate: Date
    var trainingResult: [String]
    var trainingMeasurement: [String]
    
    init(trainingName : String, trainingDate: Date, trainingResult: [String], trainingMeasurement:[String]) {
        self.trainingName = trainingName
        self.trainingDate = trainingDate
        self.trainingResult = trainingResult
        self.trainingMeasurement = trainingMeasurement
    }
    
    func getDateRelativity() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: self.trainingDate, relativeTo: Date())
        
        
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
