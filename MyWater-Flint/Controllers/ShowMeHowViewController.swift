//
//  ShowMeHowViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 4/11/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class ShowMeHowViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
        self.navigationItem.title = "Show me how..."
        self.navigationController?.navigationBar.barTintColor = Colors.colorPrimaryDark
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
