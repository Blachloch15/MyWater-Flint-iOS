//
//  Resource.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/7/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import Foundation
import RealmSwift

class Resource: Object {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var address: String = ""
    dynamic var details: String = ""
    dynamic var hours: String = ""
    dynamic var name: String = ""
    dynamic var phoneNumber: String = ""
    dynamic var resourceTypes: String = ""
    dynamic var isSaved: Bool = true
    
    override static func primaryKey() -> String? {
        return "address"
    }
}
