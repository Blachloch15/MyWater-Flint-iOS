//
//  Properties.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/4/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import Foundation

class Properties {
    
    var propertyList = [Property]()
    
    func generatePropertyList() {
        propertyList = [Property]()
        
        let path = Bundle.main.path(forResource: "mixedData", ofType: "json")
        do {
            let jsonData : NSData = try NSData(contentsOf: URL(string: "file://\(path!)")!)
            let jsonObject:AnyObject? = try JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as AnyObject
            if let itemArray = jsonObject?.object(forKey: "properties") as? NSArray {
                for item in itemArray {
                    let itemDict = item as! NSDictionary
                    let latitude = Double(itemDict["lat"] as! String)!
                    let longitude = Double(itemDict["lng"] as! String)!
                    let address = itemDict["addr"] as! String
                    let prediction = Float(itemDict["prediction"] as! String)!
                    let dateTested = itemDict["dateTested"] as! String
                    let leadLevel = Int(itemDict["leadLevel"] as! String)!
                    let isSaved = Bool(itemDict["isSaved"] as! String) ?? false
                    
                    
                    let propertyToAdd = Property()
                    propertyToAdd.latitude = latitude
                    propertyToAdd.longitude = longitude
                    propertyToAdd.address = address
                    propertyToAdd.leadLevel = leadLevel
                    propertyToAdd.predicition = prediction
                    propertyToAdd.dateTested = dateTested
                    propertyToAdd.isSaved = isSaved
                    
                    propertyList.append(propertyToAdd)
                    
                }
            }
        } catch let err as NSError {
            print("err:\(err.localizedFailureReason)")
        }
    }
    
    func saveToLocalDb(myDb: MyDb) {
        for property in propertyList {
            if (property.address != "") {
                myDb.updateProperty(property: property)
            }
        }
    }
    
}
