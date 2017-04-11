//
//  ZeroWaterViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/21/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class ZeroWaterViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
        self.navigationItem.title = "Install A Filter"
        self.navigationController?.navigationBar.barTintColor = Colors.colorPrimaryDark
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        let bundlePath = Bundle.main.path(forResource: "ic_close_white", ofType: "png")
        let icon = UIImage(contentsOfFile: bundlePath!)?.withRenderingMode(.alwaysOriginal)
        
        let leftBarButton = UIBarButtonItem(image: icon, style: UIBarButtonItemStyle.plain, target: self, action: #selector(TestPage2ViewController.goToRoot(_:)))
        self.navigationItem.setLeftBarButton(leftBarButton, animated: false)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goToRoot(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
