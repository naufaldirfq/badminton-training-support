//
//  RunningSessionView.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 12/06/21.
//

import UIKit

class RunningSessionView: UIView {

    @IBOutlet weak var mainMeasurementLabel: UILabel!
    @IBOutlet weak var mainCounterLabel: UILabel!
    @IBOutlet weak var mainUnitLabel: UILabel!
    @IBOutlet weak var leftMeasurementLabel: UILabel!
    @IBOutlet weak var leftCounterLabel: UILabel!
    @IBOutlet weak var leftUnitLabel: UILabel!
    @IBOutlet weak var rightMeasurementLabel: UILabel!
    @IBOutlet weak var rightCounterLabel: UILabel!
    @IBOutlet weak var rightUnitLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    var timer = Timer()
    
   
        
}
