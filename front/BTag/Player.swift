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
    
    var value : Player {
        get {
            return self
        }
        set {
            let player = newValue
            if self.name == player.name {
                self.lat = player.lat
                self.long = player.long
                if self.isIt != player.isIt {
                    self.isIt = !self.isIt
                }
            }
        }
    }
    
    var coord : CLLocation {
        get {
            return CLLocation(latitude: self.lat, longitude: self.long)
        }
    }

    init (name: String, lat: Double, long: Double, isIt: Bool) {
        self.name = name
        self.lat = lat
        self.long = long
        self.isIt = isIt
    }
    
    init() {
        self.name = "empty"
        self.lat = 0.0
        self.long = 0.0
        self.isIt = false
    }

}

