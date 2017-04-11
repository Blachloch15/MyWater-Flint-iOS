//
//  LeadLevelView.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/13/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class LeadLevelView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var leadLevelImageView: UIImageView!
    @IBOutlet weak var leadLevelDescriptionLabel: UILabel!
    @IBOutlet weak var leadLevelZoomWarning: UILabel!
    
    
    @IBAction func closeClicked(_ sender: Any) {
        self.isHidden = true
    }
}
