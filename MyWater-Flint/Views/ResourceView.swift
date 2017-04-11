//
//  ResourceView.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/13/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class ResourceView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var resourceName: UILabel!
    @IBOutlet weak var resourceDescription: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var getDirections: UIButton!

    @IBAction func toggleSave(_ sender: Any) {
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.isHidden = true
    }
}
