//
//  MoreInfoViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 4/3/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var resultsImageView: UIImageView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var predictionLabel: UILabel!
    
    var property: Property = Property()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (property.leadLevel == -1) {
            
            let bundlePath = Bundle.main.path(forResource: "greycirclenoline", ofType: "png")
            let icon = UIImage(contentsOfFile: bundlePath!)!
            
            resultsImageView.image = icon
            resultsLabel.text = "No test results"
            
            let prediction = property.predicition
            print(prediction)
            
            if (prediction < 0.05) {
                predictionLabel.text = "Moderate predicted lead level risk. Testing recommended."
            } else if (prediction < 0.1) {
                predictionLabel.text = "High predicted lead level risk. Testing recommended."
            } else {
                predictionLabel.text = "Very High predicted lead level risk. Testing recommended."
            }
            
        } else if (property.leadLevel < 15) {
            
            let bundlePath = Bundle.main.path(forResource: "yellowcirclenoline", ofType: "png")
            let icon = UIImage(contentsOfFile: bundlePath!)!
            
            resultsImageView.image = icon
            resultsLabel.text = "Low reported lead level"
            
            var date = property.dateTested.characters.split(separator: " ").map(String.init)
            
            predictionLabel.text = "Last tested \(date[0]) with a result of \(property.leadLevel)ppb lead."
            
        } else if (property.leadLevel < 50) {
            
            let bundlePath = Bundle.main.path(forResource: "browncirclenoline", ofType: "png")
            let icon = UIImage(contentsOfFile: bundlePath!)!
            
            resultsImageView.image = icon
            resultsLabel.text = "Moderate reported lead level"
            
            var date = property.dateTested.characters.split(separator: " ").map(String.init)
            
            predictionLabel.text = "Last tested \(date[0]) with a result of \(property.leadLevel)ppb lead."
            
        } else {
            
            let bundlePath = Bundle.main.path(forResource: "redcirclenoline", ofType: "png")
            let icon = UIImage(contentsOfFile: bundlePath!)!
            
            resultsImageView.image = icon
            resultsLabel.text = "High reported lead level"
            
            var date = property.dateTested.characters.split(separator: " ").map(String.init)
            
            predictionLabel.text = "Last tested \(date[0]) with a result of \(property.leadLevel)ppb lead."
            
        }
        
        self.navigationController?.delegate = self
        let bundlePath = Bundle.main.path(forResource: "ic_close_white", ofType: "png")
        let icon = UIImage(contentsOfFile: bundlePath!)?.withRenderingMode(.alwaysOriginal)
        let leftBarButton = UIBarButtonItem(image: icon, style: UIBarButtonItemStyle.plain, target: self, action: #selector(TestPage2ViewController.goToRoot(_:)))
        self.navigationItem.setLeftBarButton(leftBarButton, animated: false)
        self.navigationItem.title = property.address
        self.navigationController?.navigationBar.barTintColor = Colors.colorPrimaryDark
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveLocation(_ sender: Any) {
        
        let db = MyDb()
        
        db.changeSaveStateProperty(property: property)
        
    }
    
    @IBAction func getTestKits(_ sender: Any) {
        let rootView = self.navigationController?.viewControllers.first as! GoogleMapsViewController
        rootView.setOnlyTestKits()
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func callForHelp(_ sender: Any) {
        
        let number = "211"
        
        if let url = URL(string: "telprompt://\(number)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
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
