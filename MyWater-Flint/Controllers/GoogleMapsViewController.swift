//
//  GoogleMapsViewController.swift
//  MyWater-Flint
//
//  Created by John Collins on 3/1/17.
//  Copyright © 2017 University of Michigan Software. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapsViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var topScrollView: UIScrollView!
    
    let leadLevelButton = UIButton()
    let waterPickupButton = UIButton(type: UIButtonType.system)
    let waterTestKitButton = UIButton(type: UIButtonType.system)
    let waterFiltersButton = UIButton(type: UIButtonType.system)
    let bloodTestingButton = UIButton(type: UIButtonType.system)
    let recyclingButton = UIButton(type: UIButtonType.system)
    
    var showLeadLevels = true
    var isActive_waterpickup = false
    var isActive_testkits = false
    var isActive_waterfilters = false
    var isActive_bloodtesting = false
    var isActive_recycling = false
    
    var polygonList = [LeadLevelPolygon]()
    var propertyList = [Property]()
    var propertyMakerList = [GMSMarker]()
    var resourceMarkerList = [GMSMarker]()
    var realm = MyDb()
    var selectedMarker = GMSMarker()
    
    var zoomLvl: Double = 0.00
    
    @IBOutlet weak var lowView: UIView!
    @IBOutlet weak var moderateView: UIView!
    @IBOutlet weak var highView: UIView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var propertyView: PropertyView!
    @IBOutlet weak var resourceView: ResourceView!
    @IBOutlet weak var leadLevelView: LeadLevelView!
    @IBOutlet weak var addressSearchBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "MyWater-Flint"
        self.navigationController?.navigationBar.barTintColor = Colors.colorPrimaryDark
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        propertyView.isHidden = true
        resourceView.isHidden = true
        leadLevelView.isHidden = true
        
        lowView.backgroundColor = Colors.visualLowNonOpac
        moderateView.backgroundColor = Colors.visualMedNonOpac
        highView.backgroundColor = Colors.visualHighNonOpac
        noResultsView.backgroundColor = Colors.visualNoResultsNonOpac
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 43.0250378, longitude: -83.6910447, zoom: 12)

        mapView.camera = camera
        
        mapView.delegate = self
        
        mapView.bringSubview(toFront: addressSearchBox)
        
//        addressSearchBox.delegate = self
        
//        var searchBar = UISearchBar()
        
        setUpTopLevelScrollView()

        let leadLevels = LeadLevels()
        leadLevels.generateLeadLevelList()
        
        for level in leadLevels.leadLevelList {
            createPolygon(level)
        }
        
        initMapResources()
        
        let propertyQueue = DispatchQueue(label: "propertyLoad")
        let resourceQueue = DispatchQueue(label: "resourceLoad")
        
        propertyQueue.async {
            let realm = MyDb()
            let properties = Properties()
            properties.generatePropertyList()
            properties.saveToLocalDb(myDb: realm)
        }
        
        
        print("Made It")
        resourceQueue.async {
            let realm = MyDb()
            let resources = Resources()
            resources.generateResourceList()
            resources.saveToLocalDb(myDb:realm)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTopLevelScrollView()  {
        
        topScrollView.backgroundColor = Colors.colorPrimary
        
        let buttonPadding:CGFloat = 10
        var xOffset:CGFloat = 10
        
        leadLevelButton.tag = 1
        
        leadLevelButton.backgroundColor = Colors.blue
        
        leadLevelButton.setTitleColor(UIColor.white, for: .normal)
        leadLevelButton.titleLabel?.font = UIFont(name: "Title", size: 15)
        leadLevelButton.setTitle("Lead Levels", for: .normal)
        print(leadLevelButton.currentTitleColor)
        leadLevelButton.addTarget(self, action: #selector(GoogleMapsViewController.toggleLeadLevels(_:)), for: UIControlEvents.touchUpInside)
        leadLevelButton.frame = CGRect(x: 5, y: buttonPadding, width: 100, height: 50)
        
        leadLevelButton.layer.cornerRadius = 5
        leadLevelButton.layer.borderWidth = 1
        leadLevelButton.layer.borderColor = Colors.blue.cgColor
        
        topScrollView.addSubview(leadLevelButton)
        
        xOffset = 5 + CGFloat(buttonPadding) + leadLevelButton.frame.size.width
        
        let waterPickupBundlePath = Bundle.main.path(forResource: "ic_water_white", ofType: "png")
        let waterPickupIcon = UIImage(contentsOfFile: waterPickupBundlePath!)!
        waterPickupButton.setImage(waterPickupIcon, for: .normal)
//        waterPickupButton.imageView?.image = waterPickupIcon
        
        waterPickupButton.tag = 2
        
        waterPickupButton.backgroundColor = Colors.colorPrimaryDark
        waterPickupButton.setTitleColor(UIColor.white, for: .normal)
        waterPickupButton.titleLabel?.font = UIFont(name: "Title", size: 15)
        waterPickupButton.setTitle("Water Pickup", for: .normal)
        waterPickupButton.addTarget(self, action: #selector(GoogleMapsViewController.toggleWaterPickup(_:)), for: UIControlEvents.touchUpInside)
        waterPickupButton.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 150, height: 50)
        
        waterPickupButton.layer.cornerRadius = 5
        waterPickupButton.layer.borderWidth = 1
        waterPickupButton.layer.borderColor = UIColor.white.cgColor
        
        topScrollView.addSubview(waterPickupButton)
        
        xOffset = xOffset + CGFloat(buttonPadding) + waterPickupButton.frame.size.width
        
        let waterTestKitBundlePath = Bundle.main.path(forResource: "ic_leadtest_white", ofType: "png")
        let waterTestKitIcon = UIImage(contentsOfFile: waterTestKitBundlePath!)!
        waterTestKitButton.setImage(waterTestKitIcon, for: .normal)
        
        waterTestKitButton.tag = 3
        
        waterTestKitButton.backgroundColor = Colors.colorPrimaryDark
        waterTestKitButton.setTitleColor(UIColor.white, for: .normal)
        waterTestKitButton.titleLabel?.font = UIFont(name: "Title", size: 15)
        waterTestKitButton.setTitle("Water Test Kits", for: .normal)
        waterTestKitButton.addTarget(self, action: #selector(GoogleMapsViewController.toggleWaterTestKits(_:)), for: UIControlEvents.touchUpInside)
        waterTestKitButton.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 160, height: 50)
        
        waterTestKitButton.layer.cornerRadius = 5
        waterTestKitButton.layer.borderWidth = 1
        waterTestKitButton.layer.borderColor = UIColor.white.cgColor
        
        topScrollView.addSubview(waterTestKitButton)
        
        xOffset = xOffset + CGFloat(buttonPadding) + waterTestKitButton.frame.size.width
        
        let waterFiltersBundlePath = Bundle.main.path(forResource: "ic_filter_white", ofType: "png")
        let waterFiltersIcon = UIImage(contentsOfFile: waterFiltersBundlePath!)!
        waterFiltersButton.setImage(waterFiltersIcon, for: .normal)
        
        
        waterFiltersButton.tag = 4
        
        waterFiltersButton.backgroundColor = Colors.colorPrimaryDark
        waterFiltersButton.setTitleColor(UIColor.white, for: .normal)
        waterFiltersButton.titleLabel?.font = UIFont(name: "Title", size: 15)
        waterFiltersButton.setTitle("Water Filters", for: .normal)
        waterFiltersButton.addTarget(self, action: #selector(GoogleMapsViewController.toggleWaterFilters(_:)), for: UIControlEvents.touchUpInside)
        waterFiltersButton.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 160, height: 50)
        
        topScrollView.addSubview(waterFiltersButton)
        
        xOffset = xOffset + CGFloat(buttonPadding) + waterFiltersButton.frame.size.width
        
        waterFiltersButton.layer.cornerRadius = 5
        waterFiltersButton.layer.borderWidth = 1
        waterFiltersButton.layer.borderColor = UIColor.white.cgColor
        
        let bloodTestingBundlePath = Bundle.main.path(forResource: "ic_bloodtest_white", ofType: "png")
        let bloodTestingIcon = UIImage(contentsOfFile: bloodTestingBundlePath!)!
        bloodTestingButton.setImage(bloodTestingIcon, for: .normal)
        
        bloodTestingButton.tag = 5
        
        bloodTestingButton.backgroundColor = Colors.colorPrimaryDark
        bloodTestingButton.setTitleColor(UIColor.white, for: .normal)
        bloodTestingButton.titleLabel?.font = UIFont(name: "Title", size: 15)
        bloodTestingButton.setTitle("Blood Testing", for: .normal)
        bloodTestingButton.addTarget(self, action: #selector(GoogleMapsViewController.toggleBloodTesting(_:)), for: UIControlEvents.touchUpInside)
        bloodTestingButton.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 160, height: 50)
        
        bloodTestingButton.layer.cornerRadius = 5
        bloodTestingButton.layer.borderWidth = 1
        bloodTestingButton.layer.borderColor = UIColor.white.cgColor
        
        topScrollView.addSubview(bloodTestingButton)
        
        xOffset = xOffset + CGFloat(buttonPadding) + bloodTestingButton.frame.size.width
        
        let recyclingBundlePath = Bundle.main.path(forResource: "ic_recycle_white", ofType: "png")
        let recyclingIcon = UIImage(contentsOfFile: recyclingBundlePath!)!
        recyclingButton.setImage(recyclingIcon, for: .normal)
        
        recyclingButton.tag = 6
        
        recyclingButton.backgroundColor = Colors.colorPrimaryDark
        recyclingButton.setTitleColor(UIColor.white, for: .normal)
        recyclingButton.titleLabel?.font = UIFont(name: "Title", size: 15)
        recyclingButton.setTitle("Recycling", for: .normal)
        recyclingButton.addTarget(self, action: #selector(GoogleMapsViewController.toggleRecycling(_:)), for: UIControlEvents.touchUpInside)
        
        recyclingButton.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 150, height: 50)
        
        recyclingButton.layer.cornerRadius = 5
        recyclingButton.layer.borderWidth = 1
        recyclingButton.layer.borderColor = UIColor.white.cgColor
        
        topScrollView.addSubview(recyclingButton)
        
        xOffset = xOffset + CGFloat(buttonPadding) + recyclingButton.frame.size.width
        
        topScrollView.contentSize = CGSize(width: xOffset, height: topScrollView.frame.height)
        
    }
    
    func createPolygon(_ leadLevel: LeadLevel) {
        let latDist = 0.00366980384615384615384615384615;
        let lngDist = 0.00409039615384615384615384615385;
        
        var color: UIColor
        
        if (leadLevel.getWeirdness() < 0) {
            color = Colors.visualLow
        } else if (leadLevel.getWeirdness() < 0.6) {
            color = Colors.visualMed
        } else {
            color = Colors.visualHigh
        }
        
        let rect = GMSMutablePath()
        
        rect.add(CLLocationCoordinate2D(latitude: leadLevel.getLatitude()+latDist, longitude: leadLevel.getLongitude()+lngDist))
        rect.add(CLLocationCoordinate2D(latitude: leadLevel.getLatitude()-latDist, longitude: leadLevel.getLongitude()+lngDist))
        rect.add(CLLocationCoordinate2D(latitude: leadLevel.getLatitude()-latDist, longitude: leadLevel.getLongitude()-lngDist))
        rect.add(CLLocationCoordinate2D(latitude: leadLevel.getLatitude()+latDist, longitude: leadLevel.getLongitude()-lngDist))
        
        let polygon = LeadLevelPolygon(path: rect)
        
        
        polygon.fillColor = color
        polygon.strokeColor = color
        polygon.strokeWidth = 0
        polygon.isTappable = true
        polygon.leadLevel = leadLevel
        polygon.map = mapView
        
        polygonList.append(polygon)
        
    }
    
    func hidePolygons() {
        for polygon in polygonList {
            polygon.map = nil
        }
    }
    
    func showPolygons() {
        for polygon in polygonList {
            polygon.map = mapView
        }
    }
    
    
    func createZoomedView() {
        var leadLevel : Int
        
        var icon: UIImage
        let bounds = GMSCoordinateBounds(coordinate: mapView.projection.visibleRegion().nearLeft, coordinate: mapView.projection.visibleRegion().farRight)
        
        let properties = realm.getProperties(latLngBounds: bounds)
        
        for property in properties {
            leadLevel = property.leadLevel
            
            if(property.isSaved) {
                let bundlePath = Bundle.main.path(forResource: "unselectedmap", ofType: "png")
                icon = UIImage(contentsOfFile: bundlePath!)!
                icon = resizeImage(image: icon, scale: 0.4)
            } else if (leadLevel == -1) {
                let bundlePath = Bundle.main.path(forResource: "graycircle", ofType: "png")
                icon = UIImage(contentsOfFile: bundlePath!)!
            } else if (leadLevel < 15) {
                let bundlePath = Bundle.main.path(forResource: "yellowcircle", ofType: "png")
                icon = UIImage(contentsOfFile: bundlePath!)!
            } else if (leadLevel <= 50) {
                let bundlePath = Bundle.main.path(forResource: "browncircle", ofType: "png")
                icon = UIImage(contentsOfFile: bundlePath!)!
            } else if (leadLevel > 50) {
                let bundlePath = Bundle.main.path(forResource: "redcircle", ofType: "png")
                icon = UIImage(contentsOfFile: bundlePath!)!
            } else {
                let bundlePath = Bundle.main.path(forResource: "graycircle", ofType: "png")
                icon = UIImage(contentsOfFile: bundlePath!)!
            }
            
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: property.latitude, longitude: property.longitude))
            marker.icon = icon
            marker.userData = property
            marker.map = mapView
            propertyMakerList.append(marker)
            
        }
    }
    
    func hideZoomedLeadData() {
        for marker in propertyMakerList {
            if (!(marker.userData as! Property).isSaved) {
                marker.map = nil
            }
        }
        propertyMakerList.removeAll()
    }
    
    func getZoomedLeadData() {
        let properties = Properties()
        properties.generatePropertyList()
        propertyList = properties.propertyList
        createZoomedView()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let currentZoom: Double = Double(position.zoom)
        
        if (currentZoom > 16 && zoomLvl <= 16 && showLeadLevels) {
            hidePolygons()
            getZoomedLeadData()
        } else if (currentZoom <= 16 && zoomLvl > 16 && showLeadLevels) {
            hideZoomedLeadData()
            showPolygons()
        } else if (currentZoom > 16 && zoomLvl > 16 && showLeadLevels) {
            hideZoomedLeadData()
            getZoomedLeadData()
        }
        
        zoomLvl = currentZoom
    }
    
    func toggleLeadLevels(_ sender: Any) {
        let currentZoom = mapView.camera.zoom
        if (showLeadLevels) {
            showLeadLevels = false
            hidePolygons()
            hideZoomedLeadData()
            leadLevelButton.backgroundColor = Colors.colorPrimaryDark
            leadLevelButton.layer.borderColor = UIColor.white.cgColor
        } else if (currentZoom > 16 && zoomLvl <= 16 && !showLeadLevels) {
            showLeadLevels = true
            hidePolygons()
            getZoomedLeadData()
            leadLevelButton.backgroundColor = Colors.blue
            leadLevelButton.layer.borderColor = Colors.blue.cgColor
        } else if (currentZoom <= 16 && zoomLvl > 16 && !showLeadLevels) {
            showLeadLevels = true
            hideZoomedLeadData()
            showPolygons()
            leadLevelButton.backgroundColor = Colors.blue
            leadLevelButton.layer.borderColor = Colors.blue.cgColor
        } else if (currentZoom > 16 && zoomLvl > 16 && !showLeadLevels) {
            showLeadLevels = true
            hideZoomedLeadData()
            getZoomedLeadData()
            leadLevelButton.backgroundColor = Colors.blue
            leadLevelButton.layer.borderColor = Colors.blue.cgColor
        } else {
            showLeadLevels = true
            showPolygons()
            leadLevelButton.backgroundColor = Colors.blue
            leadLevelButton.layer.borderColor = Colors.blue.cgColor
        }
    }
    
    func toggleWaterPickup(_ sender: Any) {
        if (isActive_waterpickup) {
            isActive_waterpickup = false
            displayMarkersOnMap()
            
            waterPickupButton.backgroundColor = Colors.colorPrimaryDark
            waterPickupButton.layer.borderColor = UIColor.white.cgColor
            
        } else {
            isActive_waterpickup = true
            displayMarkersOnMap()
            
            waterPickupButton.backgroundColor = Colors.blue
            waterPickupButton.layer.borderColor = Colors.blue.cgColor
        }
    }
    
    func toggleWaterTestKits(_ sender: Any) {
        if (isActive_testkits) {
            isActive_testkits = false
            displayMarkersOnMap()
            
            waterTestKitButton.backgroundColor = Colors.colorPrimaryDark
            waterTestKitButton.layer.borderColor = UIColor.white.cgColor
            
        } else {
            isActive_testkits = true
            displayMarkersOnMap()
            
            waterTestKitButton.backgroundColor = Colors.blue
            waterTestKitButton.layer.borderColor = Colors.blue.cgColor
            
        }
    }
    
    func toggleWaterFilters(_ sender: Any) {
        if (isActive_waterfilters) {
            isActive_waterfilters = false
            displayMarkersOnMap()
            
            waterFiltersButton.backgroundColor = Colors.colorPrimaryDark
            waterFiltersButton.layer.borderColor = UIColor.white.cgColor
            
        } else {
            isActive_waterfilters = true
            displayMarkersOnMap()
            
            waterFiltersButton.backgroundColor = Colors.blue
            waterFiltersButton.layer.borderColor = Colors.blue.cgColor
            
        }
    }
    
    func toggleBloodTesting(_ sender: Any) {
        if (isActive_bloodtesting) {
            isActive_bloodtesting = false
            displayMarkersOnMap()
            
            bloodTestingButton.backgroundColor = Colors.colorPrimaryDark
            bloodTestingButton.layer.borderColor = UIColor.white.cgColor
            
        } else {
            isActive_bloodtesting = true
            displayMarkersOnMap()
            
            bloodTestingButton.backgroundColor = Colors.blue
            bloodTestingButton.layer.borderColor = Colors.blue.cgColor
            
        }
    }
    
    func toggleRecycling(_ sender: Any) {
        if (isActive_recycling) {
            isActive_recycling = false
            displayMarkersOnMap()
            
            recyclingButton.backgroundColor = Colors.colorPrimaryDark
            recyclingButton.layer.borderColor = UIColor.white.cgColor
            
        } else {
            isActive_recycling = true
            displayMarkersOnMap()
            
            recyclingButton.backgroundColor = Colors.blue
            recyclingButton.layer.borderColor = Colors.blue.cgColor
            
        }
    }
    
    func setOnlyTestKits() {
        
        showLeadLevels = false
        hidePolygons()
        hideZoomedLeadData()
        leadLevelButton.backgroundColor = Colors.colorPrimaryDark
        leadLevelButton.layer.borderColor = UIColor.white.cgColor
        
        isActive_waterpickup = false
        waterPickupButton.backgroundColor = Colors.colorPrimaryDark
        waterPickupButton.layer.borderColor = UIColor.white.cgColor
        
        isActive_testkits = true
        waterTestKitButton.backgroundColor = Colors.blue
        waterTestKitButton.layer.borderColor = UIColor.blue.cgColor
        
        isActive_waterfilters = false
        waterFiltersButton.backgroundColor = Colors.colorPrimaryDark
        waterFiltersButton.layer.borderColor = UIColor.white.cgColor
        
        isActive_bloodtesting = false
        bloodTestingButton.backgroundColor = Colors.colorPrimaryDark
        bloodTestingButton.layer.borderColor = UIColor.white.cgColor
        
        isActive_recycling = false
        recyclingButton.backgroundColor = Colors.colorPrimaryDark
        recyclingButton.layer.borderColor = UIColor.white.cgColor
        
        displayMarkersOnMap()
        
    }
    
    func initMapResources() {
        let resourceList = realm.getAllResources()
        for resource in resourceList {
            let latLng = CLLocationCoordinate2D(latitude: resource.latitude, longitude: resource.longitude)
            let marker = GMSMarker(position: latLng)
//            marker.setTag(resource)
            marker.userData = resource
            resourceMarkerList.append(marker)
//            marker.addTarget(self, action: #selector(GoogleMapsViewController.onMarkerClick(marker: marker)), for: UIControlEvents.touchUpInside)
            marker.map = nil
        }
        displayMarkersOnMap()
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        let leadLevelPolygon = overlay as! LeadLevelPolygon
        let leadLevel = leadLevelPolygon.leadLevel
        
        resourceView.isHidden = true
        propertyView.isHidden = true
        leadLevelView.isHidden = false
        
        leadLevelView.leadLevelDescriptionLabel.text = "\(leadLevel!.getNumberOfHighLevels()) out of \(leadLevel!.getNumberOfTests()) total test results in this area had dangerous lead levels."
        
        leadLevelView.leadLevelZoomWarning.text = "Zoom in for more specific lead test results."
        
        if (leadLevel!.getWeirdness() < 0.0) {
            
            let bundlePath = Bundle.main.path(forResource: "yellowcirclenoline", ofType: "png")
            let icon = UIImage(contentsOfFile: bundlePath!)!
            
            leadLevelView.leadLevelImageView.image = icon
            
        } else if (leadLevel!.getWeirdness() < 0.6) {
            
            let bundlePath = Bundle.main.path(forResource: "browncirclenoline", ofType: "png")
            let icon = UIImage(contentsOfFile: bundlePath!)!
            
            leadLevelView.leadLevelImageView.image = icon
            
        } else {
            
            let bundlePath = Bundle.main.path(forResource: "redcirclenoline", ofType: "png")
            let icon = UIImage(contentsOfFile: bundlePath!)!
            
            leadLevelView.leadLevelImageView.image = icon
            
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        selectedMarker = marker
        if (marker.userData is Resource) {
            let resource = marker.userData as! Resource
            
            self.leadLevelView.isHidden = true
            self.propertyView.isHidden = true
            self.resourceView.isHidden = false
            
            self.resourceView.resourceName.text = resource.name
            self.resourceView.resourceDescription.text = "\(resource.address) \(resource.hours)"
            
            if (resource.isSaved) {
                
                let bundlePath = Bundle.main.path(forResource: "ic_star_blue", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                resourceView.saveButton.imageView?.image = icon
                
            } else {
                
                let bundlePath = Bundle.main.path(forResource: "ic_start_border_blue", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                resourceView.saveButton.imageView?.image = icon
                
            }
            
            return true
        } else if (marker.userData is Property) {
            
            let property = marker.userData as! Property
            
            self.leadLevelView.isHidden = true
            self.resourceView.isHidden = true
            self.propertyView.isHidden = false
            
            if (property.leadLevel == -1) {
                
                let bundlePath = Bundle.main.path(forResource: "greycirclenoline", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                propertyView.leadLevelIcon.image = icon
                propertyView.reportedLevelLabel.text = "No test results"
                
                let prediction = property.predicition
                
                if (prediction < 0.05) {
                    propertyView.leadDescriptionLabel.text = "Moderate predicted lead level risk. Testing recommended."
                } else if (prediction < 0.1) {
                    propertyView.leadDescriptionLabel.text = "High predicted lead level risk. Testing recommended."
                } else {
                    propertyView.leadDescriptionLabel.text = "Very High predicted lead level risk. Testing recommended."
                }
                
            } else if (property.leadLevel < 15) {
                
                let bundlePath = Bundle.main.path(forResource: "yellowcirclenoline", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                propertyView.leadLevelIcon.image = icon
                propertyView.reportedLevelLabel.text = "Low reported lead level"
                
                var date = property.dateTested.characters.split(separator: " ").map(String.init)
                
                propertyView.leadDescriptionLabel.text = "Last tested \(date[0]) with a result of \(property.leadLevel)ppb lead."
                
            } else if (property.leadLevel < 50) {
                
                let bundlePath = Bundle.main.path(forResource: "browncirclenoline", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                propertyView.leadLevelIcon.image = icon
                propertyView.reportedLevelLabel.text = "Moderate reported lead level"
                
                var date = property.dateTested.characters.split(separator: " ").map(String.init)
                
                propertyView.leadDescriptionLabel.text = "Last tested \(date[0]) with a result of \(property.leadLevel)ppb lead."
                
            } else {
                
                let bundlePath = Bundle.main.path(forResource: "redcirclenoline", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                propertyView.leadLevelIcon.image = icon
                propertyView.reportedLevelLabel.text = "High reported lead level"
                
                var date = property.dateTested.characters.split(separator: " ").map(String.init)
                
                propertyView.leadDescriptionLabel.text = "Last tested \(date[0]) with a result of \(property.leadLevel)ppb lead."
                
            }
            
            if (property.isSaved) {
                
                let bundlePath = Bundle.main.path(forResource: "ic_star_blue", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                propertyView.saveButton.imageView?.image = icon
                
            } else {
                
                let bundlePath = Bundle.main.path(forResource: "ic_start_border_blue", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                propertyView.saveButton.imageView?.image = icon
                
            }
            
            return true
        }
        return false
    }
    
    func displayMarkersOnMap() {
        for marker in resourceMarkerList {
            let resource = marker.userData as! Resource
            let resourceTypes = resource.resourceTypes
            if (resource.isSaved) {
                marker.map = mapView
            }else if (resourceTypes.contains("Pickup") && isActive_waterpickup) {
                marker.map = mapView
            } else if (resourceTypes.contains("Kits") && isActive_testkits) {
                marker.map = mapView
            } else if (resourceTypes.contains("Filters") && isActive_waterfilters) {
                marker.map = mapView
            } else if (resourceTypes.contains("Blood") && isActive_bloodtesting) {
                marker.map = mapView
            } else if (resourceTypes.contains("Recycle") && isActive_recycling) {
                marker.map = mapView
            } else {
                marker.map = nil
            }
            assignMarkerIconImg(resource: resource, marker: marker)
        }
    }
    
    func assignMarkerIconImg(resource: Resource, marker: GMSMarker) {
        
        let resourceTypes = resource.resourceTypes
        var icon: UIImage
        if (resource.isSaved) {
            let bundlePath = Bundle.main.path(forResource: "unselectedmap", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
            marker.icon = resizeImage(image: icon, scale: 0.4)
        } else if (resourceTypes.contains("Pickup") && isActive_waterpickup) {
            let bundlePath = Bundle.main.path(forResource: "watermapicon", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
            marker.icon = resizeImage(image: icon, scale: 0.4)
        } else if (resourceTypes.contains("Kits") && isActive_testkits) {
            let bundlePath = Bundle.main.path(forResource: "leadtestmapicon", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
            marker.icon = resizeImage(image: icon, scale: 0.4)
        } else if (resourceTypes.contains("Filters") && isActive_waterfilters) {
            let bundlePath = Bundle.main.path(forResource: "filtermapicon", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
            marker.icon = resizeImage(image: icon, scale: 0.4)
        } else if (resourceTypes.contains("Blood") && isActive_bloodtesting) {
            let bundlePath = Bundle.main.path(forResource: "bloodmapicon", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
            marker.icon = resizeImage(image: icon, scale: 0.4)
        } else if (resourceTypes.contains("Recycle") && isActive_recycling) {
            let bundlePath = Bundle.main.path(forResource: "recyclemapicon", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
            marker.icon = resizeImage(image: icon, scale: 0.4)
        } else {
            marker.map = nil
        }
    }

    func resizeImage(image: UIImage, scale: CGFloat) -> UIImage {
        let size = image.size
        
        var newSize: CGSize
        newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getPropertyImage(property: Property, marker: GMSMarker) {
        let leadLevel = property.leadLevel
        var icon = UIImage()
        
        if(property.isSaved) {
            let bundlePath = Bundle.main.path(forResource: "unselectedmap", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
            icon = resizeImage(image: icon, scale: 0.4)
        } else if (leadLevel == -1) {
            let bundlePath = Bundle.main.path(forResource: "graycircle", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
        } else if (leadLevel < 15) {
            let bundlePath = Bundle.main.path(forResource: "yellowcircle", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
        } else if (leadLevel <= 50) {
            let bundlePath = Bundle.main.path(forResource: "browncircle", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
        } else if (leadLevel > 50) {
            let bundlePath = Bundle.main.path(forResource: "redcircle", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
        } else {
            let bundlePath = Bundle.main.path(forResource: "graycircle", ofType: "png")
            icon = UIImage(contentsOfFile: bundlePath!)!
        }
        
        marker.icon = icon
        marker.map = mapView

    }
    
    @IBAction func resourceSaveClicked(_ sender: Any) {
        
        let point = selectedMarker.userData
        
        let db = MyDb()
        
        if (point is Resource) {
            
            let resource = point as! Resource
            print("try to save resource")
            
            db.changeSaveStateResource(resource: resource)
            print("Saved")
            
//            resource.isSaved = !resource.isSaved
            selectedMarker.userData = resource
            
            if (resource.isSaved) {
                let bundlePath = Bundle.main.path(forResource: "unselectedmap", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                selectedMarker.icon = resizeImage(image: icon, scale: 0.4)
                
                let btnBundlePath = Bundle.main.path(forResource: "ic_star_blue", ofType: "png")
                let btnIcon = UIImage(contentsOfFile: btnBundlePath!)!
                
                resourceView.saveButton.imageView?.image = btnIcon
                
            } else {
                assignMarkerIconImg(resource: resource, marker: selectedMarker)
                let bundlePath = Bundle.main.path(forResource: "ic_start_border_blue", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                resourceView.saveButton.imageView?.image = icon
                
            }
            
        } else if (point is Property) {
            
            let property = point as! Property
            print("try to save property")
            db.changeSaveStateProperty(property: property)
            print("Saved")
            
//            property.isSaved = !property.isSaved
            selectedMarker.userData = property
            
            if (property.isSaved) {
                let bundlePath = Bundle.main.path(forResource: "unselectedmap", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                selectedMarker.icon = resizeImage(image: icon, scale: 0.4)
                
                let btnBundlePath = Bundle.main.path(forResource: "ic_star_blue", ofType: "png")
                let btnIcon = UIImage(contentsOfFile: btnBundlePath!)!
                
                propertyView.saveButton.imageView?.image = btnIcon
                
            } else {
                getPropertyImage(property: property, marker: selectedMarker)
                
                let bundlePath = Bundle.main.path(forResource: "ic_start_border_blue", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                
                propertyView.saveButton.imageView?.image = icon
                
                
            }
            
        }
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        let point = selectedMarker.userData
        
        let db = MyDb()
        
        if (point is Resource) {
            
            let resource = point as! Resource
            print("try to save resource")
            
            db.changeSaveStateResource(resource: resource)
            print("Saved")
            if (resource.isSaved) {
                let bundlePath = Bundle.main.path(forResource: "unselectedmap", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                selectedMarker.icon = resizeImage(image: icon, scale: 0.4)
            } else {
                assignMarkerIconImg(resource: resource, marker: selectedMarker)
            }
            
        } else if (point is Property) {
            
            let property = point as! Property
            print("try to save property")
            db.changeSaveStateProperty(property: property)
            print("Saved")
            
            if (property.isSaved) {
                let bundlePath = Bundle.main.path(forResource: "unselectedmap", ofType: "png")
                let icon = UIImage(contentsOfFile: bundlePath!)!
                selectedMarker.icon = resizeImage(image: icon, scale: 0.4)
            } else {
                getPropertyImage(property: property, marker: selectedMarker)
            }
            
        }
    }
    
    @IBAction func moreInfoClicked(_ sender: Any) {
        
        let toPush = storyboard?.instantiateViewController(withIdentifier: "MoreInfoView") as! MoreInfoViewController
        
        toPush.property = selectedMarker.userData as! Property
        
        self.navigationController?.pushViewController(toPush, animated: true)
    }
    
    @IBAction func getDirections(_ sender: Any) {
        
        var address = (selectedMarker.userData as! Resource).address
        print(address)
        
        address = address.replacingOccurrences(of: ".", with: "")
        
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        print(encodedAddress!)

        
        
        print(URL(string:"http://maps.apple.com/?daddr=" + encodedAddress!)!)
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?daddr=" + encodedAddress!)!, options: [:], completionHandler: nil)
        } else if (UIApplication.shared.canOpenURL(URL(string: "http://maps.apple.com/")!)) {
            UIApplication.shared.open(URL(string:"http://maps.apple.com/?daddr=" + encodedAddress!)!, options: [:], completionHandler: nil)
        }
        
    }

}


extension GoogleMapsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textfieldShouldBeginEditing")
    }
}
