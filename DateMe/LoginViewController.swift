//
//  LoginViewController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/10/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email", "user_friends"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.center = self.view.center;
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        if FBSDKAccessToken.current() == nil {
            UserController.shared.fetchUsersInfoFromFacebook {
                self.performSegue(withIdentifier: Constants.toConnectionViewKey, sender: self)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FBSDKAccessToken.current() != nil {
            self.performSegue(withIdentifier: Constants.toConnectionViewKey, sender: self)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Completed Login")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
}
