//
//  LobbyViewController.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/18/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPlayers()
        tableView.register(UINib(nibName: "LobbyTableViewCell", bundle: nil) , forCellReuseIdentifier: "LobbyCell")
        // Do any additional setup after loading the view.
    }
    
    var players : [Player] = []
    
    func initPlayers() {
        players.append(Player())
        players.append(Player())
        players.append(Player())
        players.append(Player())
        players.append(Player())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toMap", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LobbyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LobbyCell") as! LobbyTableViewCell
        
        if indexPath.row < players.count {
            let player = players[indexPath.row]
            cell.setup(for: player.name)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
