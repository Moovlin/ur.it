//
//  Var.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/12/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireObjectMapper
import CoreLocation
import GoogleMaps
import GoogleMapsCore
import GooglePlaces

let dbRef = "http://129.161.145.134:5000/"
struct vars {
    static var name = "tester"
}

func tag(who tagged: String, _ done: @escaping ([Player]) -> ()) {
    let url = dbRef + "tag?tagger=\(vars.name)&tagged=\(tagged)"
    do {
        let _ = try String(contentsOf: url.toURL)
        getPeople { result in
            done(result)
        }
    }
    catch {
        print(error)
    }
}

func updateLocaiton(_ location: CLLocationCoordinate2D, _ done: @escaping ([Player]) -> ()) {
    let lat = location.latitude
    let long = location.longitude
    
    let url = dbRef + "update?name=\(vars.name)&lat=\(lat)&lng=\(long)"
    do {
        let _ = try String(contentsOf: url.toURL)
        getPeople { result in
            done(result)
        }
    }
    catch {
        print(error)
    }
}

func getPeople(_ give: @escaping ([Player]) -> ()) {
    let url = dbRef + "allUsers"
    
    do {
        let string = try String(contentsOf: url.toURL)
        var result : [Player] = []
        let list = string.components(separatedBy: ",")
        for item in list {
            let properties = item.components(separatedBy: ";")
            
            let name = properties[0]
            let lat = Double(properties[1])
            let long = Double(properties[2])
            let isIt = Bool(properties[3])!
            
            result.append(Player(
                name: name,
                lat: lat!,
                long: long!,
                isIt: isIt
            ))
            
            
        }
        give(result)
    }
    catch {
        print(error)
    }
    
    
//    Alamofire.request(url.toURL).responseArray { (response: DataResponse<[Player]>) in
//        print(response.result.value)
//    }
}

extension String {
    var toURL : URL {
        let urlwithPercentEscapes = self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        return URL(string: urlwithPercentEscapes!)!
    }
}


