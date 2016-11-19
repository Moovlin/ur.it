//
//  Player.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/12/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit
import CoreLocation

class Player {
    var name: String!
    var lat: Double!
    var long: Double!
    var isIt: Bool!
    var id: String
    
    var coord : CLLocation {
        get {
            return CLLocation(latitude: self.lat, longitude: self.long)
        }
    }
    
    var coord2D : CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        }
    }

    init (name: String, lat: Double, long: Double, isIt: Bool) {
        self.name = name
        self.lat = lat
        self.long = long
        self.isIt = isIt
        self.id = UUID().uuidString
    }
    
    init() {
        self.name = "empty"
        self.lat = 0.0
        self.long = 0.0
        self.isIt = false
        self.id = "id"
    }

}

