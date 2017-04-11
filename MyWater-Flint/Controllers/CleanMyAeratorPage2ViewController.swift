//
//  CleanMyAeratorPage2ViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/21/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class CleanMyAeratorPage2ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
        let bundlePath = Bundle.main.path(forResource: "ic_close_black", ofType: "png")
        let icon = UIImage(contentsOfFile: bundlePath!)!
        
        
        let leftBarButton = UIBarButtonItem(image: icon, style: UIBarButtonItemStyle.plain, target: self, action: #selector(TestPage2ViewController.goToRoot(_:)))
        self.navigationItem.setLeftBarButton(leftBarButton, animated: false)
        
        let circle1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        
        circle1.center = CGPoint(x: (self.view.center.x - 15.0), y: 15.0)
        circle1.layer.cornerRadius = 5.0
        circle1.backgroundColor = Colors.lightGrayText
        circle1.clipsToBounds = true
        
        self.view.addSubview(circle1)
        
        
        let circle2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 15.0))
        
        circle2.center = CGPoint(x: (self.view.center.x), y: 15.0)
        circle2.layer.cornerRadius = 7.5
        circle2.backgroundColor = Colors.blue
        circle2.clipsToBounds = true
        
        self.view.addSubview(circle2)
        
        let circle3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        
        circle3.center = CGPoint(x: (self.view.center.x + 15.0), y: 15.0)
        circle3.layer.cornerRadius = 5.0
        circle3.backgroundColor = Colors.lightGrayText
        circle3.clipsToBounds = true
        
        self.view.addSubview(circle3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToRoot(_ sender: Any) {
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
