//
//  TrainingSessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

class TrainingSessionViewController: UIViewController {
    @IBOutlet weak var trainingBannerImageView: UIImageView!
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var trainingPauseButton: UIButton!
    @IBOutlet weak var trainingPlayButton: UIButton!
    @IBOutlet weak var trainingStopButton: UIButton!
    @IBOutlet weak var trainingSessionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSessionTo(vc: self )
        // Do any additional setup after loading the view.
    }
    func addSessionTo(vc: UIViewController){
        let session = RunningSessionViewController(nibName: "RunningSessionViewController", bundle: nil)
        vc.view.addSubview(session.view)
        vc.addChild(session)
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
