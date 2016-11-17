//
//  JoinViewController.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/15/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var lobby: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func joinButtonPressed(_ sender: Any) {
        
        if let id = lobby.text {
            joinLobby(id) { result in
                if result == true {
                    //Successfully joined lobby
                    vars.lobby = id
                }
                else {
                    //Lobby doesnt exist/wrong password
                }
            }
        }
        
    }
    

}
