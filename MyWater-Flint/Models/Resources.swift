//
//  Resources.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/7/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import Foundation


class Resources {
//    dynamic var latitude: Double = 0.0
//    dynamic var longitude: Double = 0.0
//    dynamic var address: String = ""
//    dynamic var details: String = ""
//    dynamic var hours: String = ""
//    dynamic var name: String = ""
//    dynamic var phoneNumber: String = ""
//    dynamic var resourceTypes: String = ""
//    dynamic var isSaved: Bool = true
    var resourceList = [Resource]()
    
    func generateResourceList() {
        
        resourceList = [Resource]()
        
        let url = URL(string: "https://storage.googleapis.com/h2o-flint.appspot.com/providers.json?key=AIzaSyD76BobwAhiW3bJux0sGVL1mZSePYZIh3E")
        
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
            
            if let itemArray = json.object(forKey: "providers") as? NSArray {
                for item in itemArray {
                    let itemDict = item as! NSDictionary
                    let latitude = Double(itemDict["latitude"] as! Double)
                    let longitude = Double(itemDict["longitude"] as! Double)
                    let address = itemDict["aidAddress"] as! String
                    let details = itemDict["notes"] as! String
                    let hours = itemDict["hours"] as! String
                    let name = itemDict["locationName"] as! String
                    let phoneNumber = itemDict["phone"] as! String
                    
                    let resources = itemDict["resType"] as! [String]
                    var resourceTypeList: String = ""
                    for resource in resources {
                        resourceTypeList.append(resource + " ")
                    }
                    
                    //                    print(resourceList)
                    
                    let isSaved = false
                    
                    //                    parseResourceValues(input: resources)
                    
                    
                    let resourceToAdd = Resource()
                    resourceToAdd.address = address
                    resourceToAdd.latitude = latitude
                    resourceToAdd.longitude = longitude
                    resourceToAdd.details = details
                    resourceToAdd.hours = hours
                    resourceToAdd.name = name
                    resourceToAdd.phoneNumber = phoneNumber
                    resourceToAdd.isSaved = isSaved
                    resourceToAdd.resourceTypes = resourceTypeList
                    
                    self.resourceList.append(resourceToAdd)
                    
                }
            }
            print(json)
        }
        
        task.resume()

    }
    
    func parseResourceValues(input: String) {
//        print(input)
    }
    
    func saveToLocalDb(myDb: MyDb) {
        for resource in resourceList {
            if (resource.address != "") {
                myDb.updateResource(resource: resource)
            }
        }
    }

}
