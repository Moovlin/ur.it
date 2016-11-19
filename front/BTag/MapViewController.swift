//
//  ViewController.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/12/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit

import CoreLocation
import GoogleMaps
import GoogleMapsCore
import GooglePlaces

import SwiftyJSON

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet var map: GMSMapView!
    @IBOutlet var tagButton: UIButton!
    

    var locationManager = CLLocationManager()

    var people : [Player] = []
    
    var markers : [GMSMarker] = []

    func checkIt() {
        let index = people.index(where: {$0.name == vars.name})
        if tagButton.isHidden == people[index!].isIt {
            tagButton.isHidden = !people[index!].isIt
        }
    }
    
    func update() {
        updateLocation(map.myLocation!.coordinate) { result in
            self.people = result
            self.checkIt()
            self.setupMarkers(for: result)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMap()
        InitButton()
        
        getPeople { (result) in
            print(result)
            self.people = result
            self.checkIt()
            self.setupMarkers(for: result)
            
            _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            
        }
    }
    
    func initMap() {
        map.delegate = self
        map.isMyLocationEnabled = true
        map.isBuildingsEnabled = false
        map.isTrafficEnabled = false
        map.isMyLocationEnabled = true
        map.isIndoorEnabled = false
        
        map.settings.compassButton = true
        map.settings.myLocationButton = true
        map.settings.indoorPicker = false
        map.settings.setAllGesturesEnabled(true)
        
        map.settings.consumesGesturesInView = false
        
        map.bringSubview(toFront: tagButton)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func InitButton() {
        tagButton.backgroundColor = UIColor(colorLiteralRed: 0, green: 0.5, blue: 1, alpha: 1)
        tagButton.layer.cornerRadius = tagButton.bounds.height / 2.25
    }
    
    func setupMarkers(for players : [Player]) {
        if markers.isEmpty {
            for player in players {
                let marker = GMSMarker()
                marker.snippet = player.id
                marker.position = player.coord2D
                marker.title = player.name
                marker.iconView = view(for: player)
                marker.map = map
                markers.append(marker)
            }
        }
        else {
            for i in 0..<markers.count {
                for player in players {
                    if player.id == markers[i].snippet {
                        markers[i].position = player.coord2D
                    }
                }
            }
        }
    }
    
    func view(for player: Player) -> UIView {
        let iv = UIView()
        iv.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        iv.layer.cornerRadius = iv.bounds.height / 2
        iv.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.5, blue: 1, alpha: 0.75)
        if player.isIt == true {
            iv.backgroundColor = UIColor.red
        }
        return iv
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            map.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateLocation(locations[0].coordinate) { result in
            self.people = result
            self.checkIt()
            self.setupMarkers(for: result)
            print(self.map.myLocation!)
        }
    }
    
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        print(people)
        let index = people.index(where: {$0.name == vars.name})
        let ownCoord = CLLocation(latitude: people[index!].lat, longitude: people[index!].long)
        var toTag = ""
        var smallestDistance : CLLocationDistance = 1000000
        for person in people {
            if person.name != vars.name {
                if ownCoord.distance(from: person.coord) <= 20 && smallestDistance > ownCoord.distance(from: person.coord) {
                    smallestDistance = ownCoord.distance(from: person.coord)
                    toTag = person.name
                }
            }
        }
        if toTag != "" {
            tag(who: toTag) { result in
                self.people = result
                self.checkIt()
                self.setupMarkers(for: result)
            }
        }
    }
}


