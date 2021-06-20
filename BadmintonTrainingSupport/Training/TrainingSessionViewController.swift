//
//  TrainingSessionViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit

protocol TrainingSessionDelegate: UIViewController {
    func didTapPlayButton()
    func didTapStopButton()
    func didTapPauseButton()
}

class TrainingSessionViewController: UIViewController {
    @IBOutlet weak var trainingBannerImageView: UIImageView!
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var trainingPauseButton: UIButton!
    @IBOutlet weak var trainingPlayButton: UIButton!
    @IBOutlet weak var trainingStopButton: UIButton!
    @IBOutlet weak var trainingSessionView: UIView!
    
    weak var delegate: TrainingSessionDelegate?
    
    var session: UIViewController?
    var disableButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add()
        if disableButton {
            trainingPlayButton.isHidden = true
            trainingStopButton.isHidden = true
            trainingPauseButton.isHidden = true
        }
    }
    
    @IBAction func didTapPlayButton(_ sender: UIButton) {
        delegate?.didTapPlayButton()
    }
    
    @IBAction func didTapPauseButton(_ sender: UIButton) {
        delegate?.didTapPauseButton()
    }
    
    @IBAction func didTapStopButton(_ sender: UIButton) {
        delegate?.didTapStopButton()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func add(){
        if let session = self.session {
            delegate = session as? TrainingSessionDelegate
            session.view.frame = trainingSessionView.frame
            view.addSubview(session.view)
            addChild(session)
        }
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
