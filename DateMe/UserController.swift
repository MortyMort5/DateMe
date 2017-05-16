//
//  UserController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    static let shared = UserController()
    let cloudKitManager = CloudKitManager()
    var currentUser: User?
    var passedByUsers: [User] = []
    var connectedUsers: [User] = []
    
    func fetchUsersInfoFromFacebook(completion: @escaping() -> Void) {
        let parameters = ["fields": "id, gender, age_range, email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest.init(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if let error = error {
                print("Error fetching User from Facebook: \(error.localizedDescription)")
                completion()
                return
            }
            guard let result = result else { return }
            guard let data = try? JSONSerialization.data(withJSONObject: result, options: .prettyPrinted) else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            guard let user = json.flatMap({ User(jsonDictionary: $0) }) else { return }
            self.currentUser = user
            completion()
        }
    }
    
    //==============================================================
    // MARK: - CloudKit Functions
    //==============================================================
    func saveUser(user: User, completion: @escaping() -> Void) {
        let record = CKRecord(user: user)
        cloudKitManager.saveRecord(record) { (record, error) in
            if let error = error {
                print("Error saving user to cloudKit: \(error.localizedDescription)")
                completion()
                return
            }
            print("Saved user to cloudKit successfully")
            completion()
        }
    }
}
