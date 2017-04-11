
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
        
        let path = Bundle.main.path(forResource: "compressedTests", ofType: "json")
        
        do {
            
            let jsonData : NSData = try NSData(contentsOf: URL(string: "file://\(path!)")!)
            let jsonObject:AnyObject? = try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as AnyObject
            if let itemArray = jsonObject?.object(forKey: "area") as? NSArray {
                for item in itemArray {
                    let itemDict = item as! NSDictionary
                    
                    let latitude = itemDict["latitude"] as! Double 
                    let longitude = itemDict["longitude"] as! Double 
                    let numberOfTests = itemDict["numOfTests"] as? Int ?? 0
                    let numberOfHighLevels = itemDict["numOfDangerous"] as? Int ?? 0
                    
                    let levelToAdd = LeadLevel(latitude: latitude, longitude: longitude, numberOfTests: numberOfTests, numberOfHighLevels: numberOfHighLevels)
                    
                    leadLevelList.append(levelToAdd)
                    
                }
            }
        } catch let err as NSError {
            print("err:\(err)")
        }
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
