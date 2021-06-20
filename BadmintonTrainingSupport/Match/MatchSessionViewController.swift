//
//  MatchSessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class MatchSessionViewController: UIViewController {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBOutlet weak var teamALabel: UILabel!
    @IBOutlet weak var teamAScorePicker: UIPickerView!
    @IBOutlet weak var teamBLabel: UILabel!
    @IBOutlet weak var teamBScorePicker: UIPickerView!
    
    @IBOutlet weak var nextSetButton: UIButton!
    @IBOutlet weak var endMatchButton: UIButton!
    
    var isPaused: Bool = true
    var totalTime: Int = 0 {
        didSet {
            var hours: Int { return self.totalTime / 3600 }
            var minutes: Int { return (self.totalTime % 3600) / 60 }
            var seconds: Int { return (self.totalTime % 60) }
            var timeString: String {
                var string = ""
                if hours > 0 {
                    string.append("\(String(format: "%02d", hours)):")
                }
                string.append("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
                return string
            }
            self.timerLabel.text = timeString
        }
    }
    
    var timer: Timer?
    var match: Match?
    var set: Int = 1
    
    var pickerData: [String] {
        var scores: [String] = []
        for i in 0...30 {
            scores.append(String(i))
        }
        return scores
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Match Session"
        headerImage.image = #imageLiteral(resourceName: "set1")
        nextSetButton.layer.cornerRadius = 10.0
        headerImage.layer.cornerRadius = 10.0
        setLabel.font = .italicSystemFont(ofSize: 32, weight: .bold)
        timerLabel.font = .italicSystemFont(ofSize: 96, weight: .bold)
        setupInterface()
        if let match = self.match {
            teamALabel.text = match.teams[0].playerNames
            teamBLabel.text = match.teams[1].playerNames
            setLabel.text = "SET \(set)"
        }
        
        if set == 3 {
            nextSetButton.isUserInteractionEnabled = false
            nextSetButton.backgroundColor = .secondaryLabel
        }
    }
    
    func setupInterface() {
        teamAScorePicker.delegate = self
        teamAScorePicker.dataSource = self
        teamBScorePicker.delegate = self
        teamBScorePicker.dataSource = self
        
        if let match = self.match {
            if match.teams[0].teamScore.indices.contains(set-1) {
                let scoreA = match.teams[0].teamScore[set-1]
                let scoreB = match.teams[1].teamScore[set-1]
                teamAScorePicker.selectRow(scoreA, inComponent: 0, animated: false)
                teamBScorePicker.selectRow(scoreB, inComponent: 0, animated: false)
                totalTime = match.durations[set-1]
            }
        }
    }
    
    @objc func timerCounter() {
        totalTime += 1
    }
    
    func toggleTime() {
        if isPaused {
            timerButton.setBackgroundImage(#imageLiteral(resourceName: "􀊘"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        } else {
            timerButton.setBackgroundImage(#imageLiteral(resourceName: "􀊖"), for: .normal)
            timer?.invalidate()
        }
        isPaused = !isPaused
    }
    
    func endMatch() {
        if !isPaused {
            toggleTime()
        }
        
        let teamAScore = teamAScorePicker.selectedRow(inComponent: 0)
        let teamBScore = teamBScorePicker.selectedRow(inComponent: 0)
        if let match = self.match {
            if match.teams[0].teamScore.indices.contains(set-1) {
                self.match?.teams[0].teamScore[set-1] = teamAScore
                self.match?.teams[1].teamScore[set-1] = teamBScore
                self.match?.durations[set-1] = totalTime
            } else {
                self.match?.teams[0].teamScore.append(teamAScore)
                self.match?.teams[1].teamScore.append(teamBScore)
                self.match?.durations.append(totalTime)
            }
        }
    }
    
    @IBAction func didToggleTime(_ sender: UIButton) {
        toggleTime()
    }
    
    @IBAction func didTapNextSet(_ sender: UIButton) {
        endMatch()
        let vc = MatchSessionViewController()
        vc.set = set+1
        vc.match = match
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapEndMatch(_ sender: UIButton) {
        endMatch()
        let vc = MatchSummaryViewController()
        vc.match = match
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MatchSessionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in //atributedtillteforrow-> kalau ada 2 pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let score = pickerData[row]
        return score
    }
}

extension UIFont {
      
    class func italicSystemFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular)-> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        switch weight {
        case .ultraLight, .light, .thin, .regular:
            return font.withTraits(.traitItalic, ofSize: size)
        case .medium, .semibold, .bold, .heavy, .black:
            return font.withTraits(.traitBold, .traitItalic, ofSize: size)
        default:
            return UIFont.italicSystemFont(ofSize: size)
        }
     }
    
     func withTraits(_ traits: UIFontDescriptor.SymbolicTraits..., ofSize size: CGFloat) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: size)
     }
      
}

