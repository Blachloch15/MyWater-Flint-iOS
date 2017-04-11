//
//  InstallFilterPage1ViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/21/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class InstallFilterPage1ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var britaButton: UIButton!
    @IBOutlet weak var purButton: UIButton!
    @IBOutlet weak var zeroWaterButton: UIButton!
    
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
        
        britaButton.tintColor = UIColor.black
        
        britaButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        britaButton.layer.borderWidth = 0.5
        britaButton.backgroundColor = UIColor.white
        britaButton.layer.borderColor = Colors.lightGrayText.cgColor
        
        purButton.tintColor = UIColor.black
        
        purButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        purButton.layer.borderWidth = 0.5
        purButton.backgroundColor = UIColor.white
        purButton.layer.borderColor = Colors.lightGrayText.cgColor
        
        zeroWaterButton.tintColor = UIColor.black
        
        zeroWaterButton.imageView!.contentMode = UIViewContentMode.scaleAspectFit
        zeroWaterButton.layer.borderWidth = 0.5
        zeroWaterButton.backgroundColor = UIColor.white
        zeroWaterButton.layer.borderColor = Colors.lightGrayText.cgColor
        
        let circle1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 15.0))
        
        circle1.center = CGPoint(x: (self.view.center.x - 15.0), y: 15.0)
        circle1.layer.cornerRadius = 7.5
        circle1.backgroundColor = Colors.blue
        circle1.clipsToBounds = true
        
        self.view.addSubview(circle1)
        
        
        let circle2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        
        circle2.center = CGPoint(x: (self.view.center.x), y: 15.0)
        circle2.layer.cornerRadius = 5.0
        circle2.backgroundColor = Colors.lightGrayText
        circle2.clipsToBounds = true
        
        self.view.addSubview(circle2)
        
        let circle3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        
        circle3.center = CGPoint(x: (self.view.center.x + 15.0), y: 15.0)
        circle3.layer.cornerRadius = 5.0
        circle3.backgroundColor = Colors.lightGrayText
        circle3.clipsToBounds = true
        
        self.view.addSubview(circle3)
        
        self.navigationController?.navigationBar.barTintColor = Colors.colorPrimary
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func adjustImageAndTitleOffsetForButton(button: UIButton) {
        let spacing: CGFloat = 6.0
        
        let imageSize = button.imageView!.frame.size
        
        button.titleEdgeInsets = UIEdgeInsets(top: (imageSize.height + spacing), left: -imageSize.width, bottom: -20, right: 0)
        
        let titleSize = button.titleLabel!.frame.size
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
    
    func goToRoot(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
