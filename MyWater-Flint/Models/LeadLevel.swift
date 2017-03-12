//
//  LeadLevel.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/3/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import Foundation

class LeadLevel {
    
    fileprivate var latitude: Double
    fileprivate var longitude: Double
    fileprivate var weirdness: Double
    fileprivate var numberOfTests: Int
    fileprivate var numberOfHighLevels: Int
    fileprivate var polygonId: String
    
    init() {
        latitude = 0
        longitude = 0
        weirdness = 0
        numberOfTests = 0
        numberOfHighLevels = 0
        polygonId = ""
    }
    
    convenience init(latitude: Double, longitude: Double, numberOfTests: Int, numberOfHighLevels: Int) {
        
        self.init()
        
        self.latitude = latitude
        self.longitude = longitude
        self.numberOfHighLevels = numberOfHighLevels
        self.numberOfTests = numberOfTests
        calculateWeirdness()
        
    }
    
    fileprivate func calculateWeirdness() {
        let N = Double(numberOfTests)
        let K = Double(numberOfHighLevels)
        
        weirdness = (K/sqrt(N)) - (sqrt(N) * 0.084)
    }
    
    func setLatitude(_ latitude: Double) {
        self.latitude = latitude
    }
    
    func getLatitude() -> Double {
        return self.latitude
    }
    
    func setLongitude(_ longitude: Double) {
        self.longitude = longitude
    }
    
    func getLongitude() -> Double {
        return self.longitude
    }
    
    func setWeirdness(_ weirdness: Double) {
        self.weirdness = weirdness
    }
    
    func getWeirdness() -> Double {
        return self.weirdness
    }
    
    func setNumberOfTests(_ numberOfTests: Int) {
        self.numberOfTests = numberOfTests
    }
    
    func getNumberOfTests() -> Int {
        return self.numberOfTests
    }
    
    func setNumberOfHighLevels(_ numberOfHighLevels: Int) {
        self.numberOfHighLevels = numberOfHighLevels
    }
    
    func getNumberOfHighLevels() -> Int {
        return self.numberOfHighLevels
    }
    
    func setPolygonId(_ polygonId: String) {
        self.polygonId = polygonId
    }
    
    func getPolygonId() -> String {
        return self.polygonId
    }
    
}
