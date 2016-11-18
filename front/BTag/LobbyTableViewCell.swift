//
//  LobbyTableViewCell.swift
//  BTag
//
//  Created by Jack O'Donnell on 11/18/16.
//  Copyright © 2016 Jack O'Donnell. All rights reserved.
//

import UIKit

class LobbyTableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(for name: String) {
        self.name.text = name
    }
    
}
