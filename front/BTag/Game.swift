//
//  Game.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/17/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit

class Game {
    
    var id : String
    var timeout: Double
    var value : Game {
        get {
            return self
        }
        set {
            if self.id != newValue.id {
                self.id = newValue.id
                self.timeout = newValue.timeout
            }
        }
    }
    
    
    init(id: String) {
        self.id = id
        self.timeout = 180
    }
    
}
