//
//  Player.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/12/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit

class Player {
    var name: String!
    var lat: Double!
    var long: Double!
    var isIt: Bool!

    init (name: String, lat: Double, long: Double, isIt: Bool) {
        self.name = name
        self.lat = lat
        self.long = long
        self.isIt = isIt
    }
}

