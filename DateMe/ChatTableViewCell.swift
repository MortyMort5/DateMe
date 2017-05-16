//
//  ChatTableViewCell.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/16/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //==============================================================
    // MARK: - Properties
    //==============================================================
    var users: [User] = []
    
    //==============================================================
    // MARK: - IBOutlets
    //==============================================================
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    

}
