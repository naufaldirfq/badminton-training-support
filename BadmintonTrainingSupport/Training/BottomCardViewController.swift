//
//  BottomCardViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 14/06/21.
//

import UIKit

protocol BottomCardViewDelegate: UITableViewCell {
    func bottomCardView(didTappedStartFor training: Training)
}

class BottomCardViewController: UIViewController {

    weak var delegate: BottomCardViewDelegate?
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var training: Training?
    
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var slideIndicator: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideIndicator.roundCorners(.allCorners, radius: 10)
        startButton.roundCorners(.allCorners, radius: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let training = self.training, let targetVC = training.targetVC {
            targetVC.view.frame = targetView.frame
            view.addSubview(targetVC.view)
            addChild(targetVC)
        }
    }
    
    @IBAction func didTapStartButton(_ sender: UIButton) {
        if let training = self.training {
            delegate?.bottomCardView(didTappedStartFor: training)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}