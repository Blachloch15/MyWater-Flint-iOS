
//
//  LeadLevels.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/3/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import Foundation

class LeadLevels {
    
    var leadLevelList = [LeadLevel]()
    
    
    func generateLeadLevelList() {
        leadLevelList = [LeadLevel]()
        
        let url = URL(string: "https://storage.googleapis.com/h2o-flint.appspot.com/leadLevels_birdview.json?key=AIzaSyD76BobwAhiW3bJux0sGVL1mZSePYZIh3E")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            print(data)
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            
            if let itemArray = json.object(forKey: "area") as? NSArray {
                for item in itemArray {
                    let itemDict = item as! NSDictionary
                    
                    let latitude = itemDict["latitude"] as! Double
                    let longitude = itemDict["longitude"] as! Double
                    let numberOfTests = itemDict["numOfTests"] as? Int ?? 0
                    let numberOfHighLevels = itemDict["numOfDangerous"] as? Int ?? 0
                    
                    let levelToAdd = LeadLevel(latitude: latitude, longitude: longitude, numberOfTests: numberOfTests, numberOfHighLevels: numberOfHighLevels)
                    
                    self.leadLevelList.append(levelToAdd)
                    
                }
            }
            
            print(json)
        }
        
        task.resume()
    }
    
    func getJSON(_ urlToRequest: String) -> Data {
        do {
        return try Data(contentsOf: URL(string: urlToRequest)!)
        } catch let error as NSError {
            print (error)
        }
        return Data()
    }
    
    func parseJSON(_ inputData: Data) -> NSDictionary {
        do {
        let boardsDictionary: NSDictionary = try JSONSerialization.jsonObject(with: inputData as Data, options: .allowFragments) as! [String: Any] as NSDictionary
        print (boardsDictionary["area"] as? [[String: Any]] ?? [])
            return boardsDictionary
        } catch let error as NSError {
            print(error)
        }
        return NSDictionary()
        
    }
    
}
