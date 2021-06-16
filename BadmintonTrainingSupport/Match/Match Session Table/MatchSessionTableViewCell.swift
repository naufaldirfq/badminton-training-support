//
//  MatchSessionTableViewCell.swift
//  BadmintonTrainingSupport
//
//  Created by Dhika Aditya Are on 14/06/21.
//

import UIKit

class MatchSessionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var msImage: UIImageView!
    @IBOutlet weak var numberOfSetLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var imageStartStop: UIImageView!
    @IBOutlet weak var buttonStartStop: UIButton!
    
    @IBOutlet weak var teamALabel: UILabel!
    @IBOutlet weak var teamBLabel: UILabel!
    
    //MARK: Picker Score
    @IBOutlet weak var scoreTeamMate: UIPickerView!
    @IBOutlet weak var scoreOpponent: UIPickerView!
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var buttonNextSet: UIButton!
    
    //MARK: Images
    var image: UIImage = Images.defaultTraining
    
    //MARK: Timer
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    //MARK: Validasi Set
    var numberTemp = 1
    
    //MARK: Variable Global
    var saveTimeToDatabase: String?
    var savePickerPickScore1: String?
    var savePickerPickScore2: String?
    var saveSetData: String?
    
    static let identifier = "MatchSessionTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MatchSessionTableViewCell", bundle: nil)
    }
  
    public func configure(with match: Match) {
        teamALabel.text = match.teams[0].playerNames
        teamBLabel.text = match.teams[1].playerNames
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        msImage.image = image
        imageStartStop.image = #imageLiteral(resourceName: "􀊖")
        setupStyles()
        
        self.scoreTeamMate.delegate = self
        self.scoreOpponent.delegate = self
        
        //MARK: Picker Data
        pickerData = []
        for i in 0...23 {
            pickerData.append(String(i))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didStartStopTime(_ sender: UIButton) {
        if (timerCounting){
            //MARK: Start
            timerCounting = false
            timer.invalidate()
            imageStartStop.image = #imageLiteral(resourceName: "􀊖")
 
        }else{
            timerCounting = true
            imageStartStop.image = #imageLiteral(resourceName: "􀊘")

            
            timer = Timer.scheduledTimer(timeInterval: 0.00001, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            //change time interval to fastt 1 -> 0.00001
        }
    }
    @objc func timerCounter() -> Void{
        count = count + 1

        let timeScreen = secondToMinutesSeconds(seconds: count)
        let timeStringScreen = returnToStringScreen(minutes: timeScreen.0, seconds: timeScreen.1)
        timerLabel.text = timeStringScreen
        
        let finalTime = returnTimeAndEdit(minutes: timeScreen.0, seconds: timeScreen.1)
        //MARK: Nanti finalTime bakal diambil valuenya
        //print(finalTime)
        saveTimeToDatabase = finalTime

    }
    
    func secondToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return (seconds/60, ((seconds%3600)%60))
    }
    
    //MARK: Return String Waktu ke Label
    func returnToStringScreen(minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
    
        return timeString
    }
    
    //MARK: Melakukan perhitungan minutes to hours and minutes
    func returnTimeAndEdit(minutes: Int, seconds: Int) -> String {
        var finalFullTimeString = ""
        
        let finalHours = minutes/60
        var finalMinutes = minutes
        
        //MARK: Validasi Minutes
        if finalMinutes < 59{
            finalMinutes = minutes
        } else if finalMinutes > 59{
            //MARK: Validasi jika perhitungan masih lebih besar dari 60
            repeat {
                finalMinutes = finalMinutes - 60
            }while(finalMinutes>=60)
            
        }

        finalFullTimeString += String(format: "%02d",finalHours)
        finalFullTimeString += " : "
        finalFullTimeString += String(format: "%02d", finalMinutes)
        finalFullTimeString += " : "
        finalFullTimeString += String(format: "%02d", seconds)

        return finalFullTimeString
    }
    
    
    //MARK: Button
    @IBAction func actionNextSet(_ sender: UIButton) {
        saveToDatabase()
        if numberTemp < 3 {
            numberTemp = numberTemp + 1
            let xSet = "SET \(numberTemp)"
            numberOfSetLabel.text = xSet
            
            saveSetData = xSet
            
            //MARK: Reset All Input Value
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = returnToStringScreen(minutes: 0, seconds: 0)
        
            scoreTeamMate.selectRow(0, inComponent: 0, animated: true)
            scoreOpponent.selectRow(0, inComponent: 0, animated: true)
        }else{
            buttonNextSet.isEnabled = false
        }
    }
    
    @IBAction func actionEndMatch(_ sender: UIButton) {
        print("End Match")
        if numberTemp < 3 {
            saveToDatabase()
        }
    }
    
    func saveToDatabase() {
        //MARK: Save to Database
        print("Set Ke :\(saveSetData ?? "SET 1")")
        print(saveTimeToDatabase ?? "errorSaveTime")
        //print(savePickerPick ?? "errorSavePicker")
        print("Our Score: \(savePickerPickScore1 ?? "Error Score")")
        print("Opponent Score: \(savePickerPickScore2 ?? "Error Score")")
        
        let defaults = UserDefaults.standard
        defaults.setValue(saveSetData, forKey: MSstore.Set)
        defaults.setValue(saveTimeToDatabase, forKey: MSstore.Time)
        defaults.setValue(savePickerPickScore1, forKey: MSstore.ScoreTeammate)
        defaults.setValue(savePickerPickScore2, forKey: MSstore.ScoreOpponent)
    }
    
    func setupStyles(){
        buttonNextSet.layer.cornerRadius = 10.0
        msImage.layer.cornerRadius = 10.0
    }
}


extension MatchSessionTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in //atributedtillteforrow-> kalau ada 2 pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return pickerData[row]
        if pickerView == scoreTeamMate{
            let titleRow1 = pickerData[row]
            return titleRow1
        }else if pickerView == scoreOpponent{
            let titleRow2 = pickerData[row]
            return titleRow2
            
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == scoreTeamMate {
            let pickerValue = self.pickerData[row] as String
            self.savePickerPickScore1 = pickerValue
            
        } else if pickerView == scoreOpponent {
            //self.textbox2.text = self.Gender[row]
            let pickerValue = self.pickerData[row] as String
            self.savePickerPickScore2 = pickerValue
        }
    }
}
