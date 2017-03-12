//
//  Property.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/4/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import Foundation
import RealmSwift

class Property : Object {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var address: String = ""
    dynamic var leadLevel: Int = 0
    dynamic var predicition: Float = 0.0
    dynamic var dateTested: String = ""
    dynamic var isSaved: Bool = true
    
    override static func primaryKey() -> String? {
        return "address"
    }
    
}

//class Property {
//    
//    var latitude: Double
//    var longitude: Double
//    var address: String
//    var leadLevel: Int
//    var prediction: Float
//    var dateTested: String
//    var isSaved: Bool
//    
//    required init() {
//        latitude = 0.00
//        longitude = 0.00
//        address = ""
//        leadLevel = 0
//        prediction = 0.00
//        dateTested = ""
//        isSaved = true
//    }
//    
//    convenience init(latitude: Double, longitude: Double, address: String, leadLevel: Int, prediction: Float, dateTested: String, isSaved: Bool) {
//        
//        self.init()
//        
//        self.latitude = latitude
//        self.longitude = longitude
//        self.address = address
//        self.leadLevel = leadLevel
//        self.prediction = prediction
//        self.dateTested = dateTested
//        self.isSaved = isSaved
//        
//    }
//
//    func setLatitude(_ latitude: Double) {
//        self.latitude = latitude
//    }
//    
//    func getLatitude() -> Double {
//        return self.latitude
//    }
//    
//    func setLongitude(_ longitude: Double) {
//        self.longitude = longitude
//    }
//    
//    func getLongitude() -> Double {
//        return self.longitude
//    }
//    
//    func setAddress(_ address: String) {
//        self.address = address
//    }
//    
//    func getAddress() -> String {
//        return self.address
//    }
//    
//    func setLeadLevel(_ leadLevel: Int) {
//        self.leadLevel = leadLevel
//    }
//    
//    func getLeadLevel() -> Int {
//        return self.leadLevel
//    }
//    
//    func setPrediction(_ prediction: Float) {
//        self.prediction = prediction
//    }
//    
//    func getPrediction() -> Float {
//        return self.prediction
//    }
//    
//    func setDateTested(_ dateTested: String) {
//        self.dateTested = dateTested
//    }
//    
//    func getDateTested() -> String {
//        return self.dateTested
//    }
//    
//    func setIsSaved(_ isSaved: Bool) {
//        self.isSaved = isSaved
//    }
//    
//    func getIsSaved() -> Bool {
//        return self.isSaved
//    }
//}
