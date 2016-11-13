//
//  Player.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/12/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit

import AlamofireObjectMapper
import ObjectMapper


class Player : Mappable {
    var name: String!
    var lat: Double!
    var long: Double!
    var isIt: Bool!
    
    required init?(map: Map){
        
    }
    
    init (name: String, lat: Double, long: Double, isIt: Bool) {
        self.name = name
        self.lat = lat
        self.long = long
        self.isIt = isIt
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        lat <- map["latitude"]
        long <- map["longitute"]
        //isIt <- map["it"]
    }
}

