//
//  RunningSessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 14/06/21.
//

import UIKit

class RunningSessionViewController: UIViewController {

    @IBOutlet weak var mainMeasurementLabel: UILabel!
    @IBOutlet weak var mainUnitLabel: UILabel!
    @IBOutlet weak var mainCounterLabel: UILabel!
    @IBOutlet weak var leftMeasurementLabel: UILabel!
    @IBOutlet weak var leftCounterLabel: UILabel!
    @IBOutlet weak var leftUnitLabel: UILabel!
    @IBOutlet weak var rightMeasurementLabel: UILabel!
    @IBOutlet weak var rightCounterLabel: UILabel!
    @IBOutlet weak var rightUnitLabel: UILabel!
    
    private var trainingSession: TrainingSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dcf = DateComponentsFormatter()
        dcf.allowedUnits = [ .hour, .minute, .second]
        dcf.unitsStyle = .full
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        if let future = df.date(from: "2022-06-14 15:07:39"), let diff = dcf.string(from: Date(), to: future) {
            print(diff)
        }
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RunningSessionViewController: TrainingSessionDelegate {
    func didTapPlayButton() {
        print("play")
    }
    
    func didTapStopButton() {
        FirestoreReferenceManager.db.collection("training_history").addDocument(data: [
            "time": 10,
            "distance": 100,
            "pace": 10,
            "training_name": FirestoreReferenceManager.db.document("training_category/physical/trainings/running")
        ])
        print("data added")
    }
    
    func didTapPauseButton() {
        print("pause")
    }
    
    
}
