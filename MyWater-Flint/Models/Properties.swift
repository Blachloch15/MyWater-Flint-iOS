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
        
        let url = URL(string: "https://storage.googleapis.com/h2o-flint.appspot.com/properties.json?key=AIzaSyD76BobwAhiW3bJux0sGVL1mZSePYZIh3E")
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
            
            if let itemArray = json.object(forKey: "properties") as? NSArray {
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
                    
                    self.propertyList.append(propertyToAdd)
                    
                }
                
            }
            
            print(json)
        }
        
        task.resume()
    }
    
    func saveToLocalDb(myDb: MyDb) {
        for property in propertyList {
            if (property.address != "") {
                myDb.updateProperty(property: property)
            }
        }
    }
    
}
