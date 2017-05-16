//
//  ProfileViewController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/15/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    
    var currentUser: User? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUser = UserController.shared.currentUser
    }
    
    func updateViews() {
        guard let user = currentUser else { return }
        emailLabel.text = user.email
        genderLabel.text = user.gender
        ageLabel.text = "\(user.age)"
        lastNameLabel.text = user.lastName
        firstNameLabel.text = user.firstName
        profileImageView.image = user.profileImage
    }
    
}
