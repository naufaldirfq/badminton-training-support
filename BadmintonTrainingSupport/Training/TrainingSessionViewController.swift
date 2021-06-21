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
    func setupSummaryView()
}

class TrainingSessionViewController: UIViewController {
    @IBOutlet weak var trainingBannerImageView: UIImageView!
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var trainingPauseButton: UIButton!
    @IBOutlet weak var trainingPlayButton: UIButton!
    @IBOutlet weak var trainingStopButton: UIButton!
    @IBOutlet weak var trainingSessionView: UIView!
    
    weak var delegate: TrainingSessionDelegate?
    var session: TrainingSession?
    var isSummary = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSession()
        trainingNameLabel.font = .italicSystemFont(ofSize: 32, weight: .bold)
        trainingPauseButton.isHidden = true
        if isSummary {
            trainingPlayButton.isHidden = true
            trainingStopButton.isHidden = true
        }
    }
    
    func toggleButton() {
        trainingPlayButton.isHidden = !trainingPlayButton.isHidden
        trainingPauseButton.isHidden = !trainingPauseButton.isHidden
        trainingStopButton.isHidden = !trainingStopButton.isHidden
    }
    
    func finishButton() {
        trainingPlayButton.isHidden = true
        trainingPauseButton.isHidden = true
        trainingStopButton.setImage(UIImage(systemName: "flag.circle.fill")!, for: .normal)
        trainingStopButton.isHidden = false
    }
    
    @IBAction func didTapPlayButton(_ sender: UIButton) {
        toggleButton()
        delegate?.didTapPlayButton()
    }
    
    @IBAction func didTapPauseButton(_ sender: UIButton) {
        toggleButton()
        delegate?.didTapPauseButton()
    }
    
    @IBAction func didTapStopButton(_ sender: UIButton) {
        delegate?.didTapStopButton()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupSession(){
        guard let name = self.session?.name else { return }
        var vc: UIViewController?
        switch name {
        case "Running":
            vc = RunningSessionViewController(nibName: "RunningSessionViewController", bundle: nil)
        default:
            vc = SetRepSessionViewController(nibName: "SetRepSessionViewController", bundle: nil)
        }
        trainingBannerImageView.image = UIImage(named: name)
        delegate = vc as? TrainingSessionDelegate
        if let session = vc as? SessionViewController {
            session.trainingSession = self.session
            session.delegate = self
            session.view.frame = trainingSessionView.frame
            view.addSubview(session.view)
            addChild(session)
            trainingNameLabel.text = self.session?.name.uppercased() ?? ""
            if isSummary {
                session.setupSummaryView()
            }
        }
    }

}
