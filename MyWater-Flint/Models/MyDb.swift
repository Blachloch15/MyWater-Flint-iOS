//
//  MyDb.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/4/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import Foundation
import RealmSwift
import GoogleMaps

class MyDb {
    
    private var realm: Realm
    
    init() {
        do {
            var configuration = Realm.Configuration()
            
            configuration.fileURL = configuration.fileURL!.deletingLastPathComponent().appendingPathComponent("MyWater.realm")
            realm = try Realm(configuration: configuration)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateProperty(property: Property) {
        do {
            try realm.write {
                realm.add(property, update: true)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func changeSaveStateProperty(property: Property) {
        if (!property.isSaved) {
            print("you have saved a property")
        }
        else {
            print("you have unsaved a property")
        }
        do {
            try realm.write {
                property.isSaved = !property.isSaved
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveProperty(property: Property) {
        do {
            try realm.write {
                property.isSaved = true
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func unSaveProperty(property: Property) {
        do {
            try realm.write {
                property.isSaved = false
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func getSavedProperties()->Results<Property> {
        let properties = realm.objects(Property.self).filter("isSaved = true")
        return properties
    }
    
    func getAllProperties()->Results<Property> {
        let properties = realm.objects(Property.self)
        return properties
    }
    
    func getProperties(latLngBounds: GMSCoordinateBounds)->Results<Property> {
        let upperLat = latLngBounds.northEast.latitude
        let upperLng = latLngBounds.northEast.longitude
        let lowerLat = latLngBounds.southWest.latitude
        let lowerLng = latLngBounds.southWest.longitude
        
        let properties = realm.objects(Property.self).filter("latitude between {%@, %@} and longitude between {%@, %@}", lowerLat, upperLat, lowerLng, upperLng)
        
        return properties
        
    }
    
    func getProperty(addr: String)->Results<Property> {
        let properties = realm.objects(Property.self).filter("address == %@", addr)
        return properties
    }
    
    func deleteProperty(property: Property) {
        realm.delete(property)
    }
    
    func deleteAllProperties() {
        do {
            try realm.write {
                realm.delete(realm.objects(Property.self))
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateResource(resource: Resource) {
        do {
            try realm.write {
                realm.add(resource, update: true)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func changeSaveStateResource(resource: Resource) {
        do {
            try realm.write {
                resource.isSaved = !resource.isSaved
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveResource(resource: Resource) {
        do {
            try realm.write {
                resource.isSaved = true
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func unSaveResource(resource: Resource) {
        do {
            try realm.write {
                resource.isSaved = false
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAllResources()->Results<Resource> {
        let resources = realm.objects(Resource.self)
        return resources
    }
    
    func deleteResource(resource: Resource) {
        realm.delete(resource)
    }
    
    func deleteAllResources() {
        realm.delete(realm.objects(Resource.self))
    }
    
}
