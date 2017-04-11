//
//  PropertyView.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/13/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class PropertyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var leadLevelIcon: UIImageView!
    @IBOutlet weak var reportedLevelLabel: UILabel!
    @IBOutlet weak var leadDescriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var moreInformationButton: UIButton!

    @IBAction func closeClicked(_ sender: Any) {
        self.isHidden = true
    }
    
    @IBAction func toggleSave(_ sender: Any) {
        
        
        
    }
    
    
}
