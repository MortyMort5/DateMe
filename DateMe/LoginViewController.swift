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
        
        if let _ = FBSDKAccessToken.current() {
            self.performSegue(withIdentifier: "toConnectionView", sender: self)
        } else {
            UserController.shared.fetchUsersInfoFromFacebook {
                self.performSegue(withIdentifier: "toConnectionView", sender: self)
            }
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
