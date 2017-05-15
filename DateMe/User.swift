//
//  User.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CloudKit

class User: Equatable {
    
    let firstName: String
    let lastName: String
    let age: Int
    let email: String
    let gender: String
    let chats: [Chat]
    var passedByConnections: [CKReference] = []
    var acceptedConnections: [CKReference] = []
    var profileImageData: Data?
    let appleDefaultUserRef: CKReference?
    var userRecordID: CKRecordID?
    
    var temporaryPhotoURL: URL? {
        let tempDir = NSTemporaryDirectory()
        let tempURL = URL(fileURLWithPath: tempDir)
        let fileURL = tempURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        guard let profileImageData = profileImageData else { return nil }
        try? profileImageData.write(to: fileURL, options: [.atomic])
        return fileURL
    }
    
    var profileImage: UIImage? {
        guard let imageData = profileImageData else { return nil }
        guard let image = UIImage(data: imageData) else { return UIImage() }
        return image
    }
    
    init(firstName: String, lastName: String, age: Int, email: String, gender: String, chats: [Chat] = [], profileImageData: Data, appleDefaultUserRef: CKReference) {
        self.firstName =  firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.gender = gender
        self.chats = chats
        self.profileImageData = profileImageData
        self.appleDefaultUserRef = appleDefaultUserRef
    }
    
    init?(record: CKRecord) {
        guard let firstName = record[Constants.firstNameKey] as? String,
            let lastName = record[Constants.lastNameKey] as? String,
            let age = record[Constants.ageKey] as? Int,
            let email = record[Constants.emailKey] as? String,
            let gender = record[Constants.genderKey] as? String,
            let photoAsset = record[Constants.profileImageDataKey] as? CKAsset,
            let appleDefaultUserRef = record[Constants.appleDefaultUserRefKey] as? CKReference else { return nil }
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.gender = gender
        let imageDataOpt = try? Data(contentsOf: photoAsset.fileURL)
        guard let imageData = imageDataOpt else { return nil }
        self.profileImageData = imageData
        self.appleDefaultUserRef = appleDefaultUserRef
        self.chats = []
        self.userRecordID = record.recordID
    }
    
    init?(jsonDictionary: [String: Any]) {
        guard let firstName = jsonDictionary[Constants.firstNameKey] as? String,
            let lastName = jsonDictionary[Constants.lastNameKey] as? String,
            let ageDict = jsonDictionary[Constants.ageRandgeDictionaryKey] as? [String: Any],
            let age = ageDict[Constants.minAgeKey] as? Int,
            let email = jsonDictionary[Constants.emailKey] as? String,
            let gender = jsonDictionary[Constants.genderKey] as? String,
            let pictureDict = jsonDictionary[Constants.pictureDictionaryKey] as? [String: Any],
            let urlDict = pictureDict[Constants.dataDictionaryKey] as? [String: Any],
            let photoURL = urlDict[Constants.facebookImageURLKey] as? String else { return nil }
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.gender = gender
        self.appleDefaultUserRef = nil
        self.userRecordID = nil
        self.chats = []
        ImageController.image(forURL: photoURL) { (image) in
            guard let image = image,
            let data = UIImageJPEGRepresentation(image, 1.0) else { return }
            self.profileImageData = data
        }
    }
}

extension CKRecord {
    convenience init(user: User) {
        let recordID = user.userRecordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Constants.userRecordTypeKey, recordID: recordID)
        self.setValue(user.firstName, forKey: Constants.firstNameKey)
        self.setValue(user.lastName, forKey: Constants.lastNameKey)
        self.setValue(user.age, forKey: Constants.ageKey)
        self.setValue(user.email, forKey: Constants.emailKey)
        self.setValue(user.gender, forKey: Constants.genderKey)
        guard let photoURL = user.temporaryPhotoURL else { return }
        let imageAsset = CKAsset(fileURL: photoURL)
        self.setValue(imageAsset, forKey: Constants.profileImageDataKey)
        self.setValue(user.appleDefaultUserRef, forKey: Constants.appleDefaultUserRefKey)
    }
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs === rhs
}














