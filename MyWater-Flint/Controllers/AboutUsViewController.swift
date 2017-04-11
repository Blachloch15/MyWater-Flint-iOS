//
//  AboutUsViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 2/10/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit

class AboutUsViewController: ViewController {

    @IBOutlet weak var aboutUsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let htmlString = "<p><strong>Any user of the MyWater-Flint data portal application (\"MyWater-Flint\") agrees to all of the following disclaimers, waives any and all claims against, and agrees to hold harmless, the Regents of the University of Michigan, its board members, officers, employees, agent and students (collectively, \"University\") with regard to any matter related to the use or the contents of MyWater-Flint.</strong></p>\n" + "" + "<p>The data displayed on MyWater-Flint are provided as a public service, on an \"AS-IS\" basis, and for informational purposes only. University does not create these data, vouch for their accuracy, or guarantee that these are the most recent data available from the data provider. For many or all of the data, the data are by their nature approximate and will contain some inaccuracies. The data may contain errors introduced by the data provider(s) and/or by University. The names of counties and other locations shown in MyWater-Flint may differ from those in the original data.\n" + "                <br /> <br />" + "University makes no warranty, representation or guaranty of any type as to any errors and omissions, or as to the content, accuracy, timeliness, completeness or fitness for any particular purpose or use of any data provided on MyWater-Flint; nor is it intended that any such warranty be implied, including, without limitation, the implied warranties of merchantability and fitness for a particular purpose.  Furthermore, University (a) expressly disclaims the accuracy, adequacy, or completeness of any data and (b) shall not be liable for any errors, omissions or other defects in, delays or interruptions in such data, or for any actions taken or not taken in reliance upon such data. Neither University nor any of its data providers will be liable for any damages relating to your use of the data provided in MyWater-Flint.\n" + "                <br /> <br />" + "University shall reserve the right to discontinue the availability of any content on MyWater-Flint at any time and for any reason or no reason at all. The user assumes the entire risk related to its use of the data on MyWater-Flint. In no event will University be liable to you or to any third party for any direct, indirect, incidental, consequential, special or exemplary damages or lost profit resulting from any use or misuse of these data.</p>\n";

        if let htmlData = htmlString.data(using: String.Encoding.unicode) {
            do {
                let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                aboutUsLabel.attributedText = attributedText
            } catch let e as NSError {
                print("Couldn't translate \(htmlString): \(e.localizedDescription) ")
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
