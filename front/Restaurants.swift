////
////  Restaurants.swift
////  BTag
////
////  Created by BTag team on 11/13/16.
////  Copyright © 2016 Jack O'Donnell. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
////let dbRef = "http://129.161.145.134:5000/"
//
//
//class RestaurantView: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    override func viewDidload() {
//        super.viewDidLoad()
//        
//        let url = dbRef + "restaurants?lat=\(lat)&lng=\(long)"
//        do {
//            let _ = try String(contentsOf: url.toURL)
//            getPeople { result in
//                done(result)
//            }
//        }
//        catch {
//            print(error)
//        }
//        
//        var head:UIToolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.width , 50))
//        
//        var back:UIBarButtonItem = UIBarButtonItem(title: "Back", style: Plain, target: nil, action: #selector(goBack))
//        
//        var mytable:UITableView = UITableView()
//        mytable.delegate = self
//        
//        self.view!.addSubview(mytable)
//    }
//    
//    func goBack() {
//        super.dismiss(animated: true, completion: nil)
//    }
// 
//    
//}
