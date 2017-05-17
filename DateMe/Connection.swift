//
//  Connection.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/16/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CloudKit

class Connection: NSObject, NSCoding {
    
    var locationImageData: Data?
    var countDownSinceConnected: TimeInterval?
    let timestamp: Date
    var user: User?
    let uuid: String
    var enabled: Bool
    var passedByConnection: CKReference?
    var recordID: CKRecordID?
    // When both are added to the likedConnections array then they become friends and are added to the friends array in the User Object. This means both of them liked each other and have "Matched"
    var likedConnections: [CKReference] = []
    
    var locationPhotoURL: URL? {
        let tempDir = NSTemporaryDirectory()
        let tempURL = URL(fileURLWithPath: tempDir)
        let fileURL = tempURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        guard let locationImageData = self.locationImageData else { return nil }
        try? locationImageData.write(to: fileURL, options: [.atomic])
        return fileURL
    }
    
    var locationImage: UIImage? {
        guard let imageData = self.locationImageData else { return nil }
        guard let image = UIImage(data: imageData) else { return UIImage() }
        return image
    }
    
    init(locationImageData: Data, countDownSinceConnected: TimeInterval, timestamp: Date = Date(), enabled: Bool, user: User, uuid: String, passedByConnection: CKReference) {
        self.locationImageData = locationImageData
        self.countDownSinceConnected = countDownSinceConnected
        self.timestamp = timestamp
        self.user = user
        self.uuid = uuid
        self.enabled = enabled
        self.passedByConnection = passedByConnection
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let uuid = aDecoder.decodeObject(forKey: Constants.uuidKey) as? String,
            let timestamp = aDecoder.decodeObject(forKey: Constants.connectionTimestampKey) as? Date else { return nil }
        self.countDownSinceConnected = TimeInterval(aDecoder.decodeDouble(forKey: Constants.countDownSinceConnectedKey))
        self.enabled = aDecoder.decodeBool(forKey: Constants.enabledKey)
        self.timestamp = timestamp
        self.uuid = uuid
    }
    
    init?(record: CKRecord) {
        guard let photoAsset = record[Constants.locationImageDataKey] as? CKAsset,
            let timestamp = record.creationDate,
            let user = record[Constants.userKey] as? User,
            let uuid = record[Constants.uuidKey] as? String,
            let enabled = record[Constants.enabledKey] as? Bool,
            let passedByConnection = record[Constants.passedByConnectionKey] as? CKReference,
            let likedConnections = record[Constants.likedConnectionsKey] as? [CKReference] else { return nil }
        let imageDataOpt = try? Data(contentsOf: photoAsset.fileURL)
        guard let imageData = imageDataOpt else { return nil }
        self.locationImageData = imageData
        self.timestamp = timestamp
        self.user = user
        self.uuid = uuid
        self.recordID = record.recordID
        self.enabled = enabled
        self.passedByConnection = passedByConnection
        self.likedConnections = likedConnections
    }
    
    func dictionaryRepresentation() -> [String: Any] {
        return [
            Constants.countDownSinceConnectedKey: countDownSinceConnected ?? 0.0,
            Constants.enabledKey: enabled,
            Constants.uuidKey: uuid,
            Constants.connectionTimestampKey: timestamp
        ]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.countDownSinceConnected, forKey: Constants.countDownSinceConnectedKey)
        aCoder.encode(self.enabled, forKey: Constants.enabledKey)
        aCoder.encode(self.uuid, forKey: Constants.uuidKey)
        aCoder.encode(self.timestamp, forKey: Constants.connectionTimestampKey)
    }
    
    var fireDate: Date? {
        print("fireDate")
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight, let countDown = countDownSinceConnected else { return nil }
        let fireDate = Date(timeInterval: countDown, since: thisMorningAtMidnight as Date)
        return fireDate
    }
    
    var fireTimeAsString: String {
        print("fireTimeAsString")
        guard let countDown = self.countDownSinceConnected else { return "" }
        let countDownSinceConnected = Int(countDown)
        var hours = countDownSinceConnected/60/60
        let minutes = (countDownSinceConnected - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
}

func ==(lhs: Connection, rhs: Connection) -> Bool {
    return lhs.uuid == rhs.uuid
}

extension CKRecord {
    convenience init(connection: Connection) {
        let recordID = connection.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Constants.connectionTypeKey, recordID: recordID)
        guard let photoURL = connection.locationPhotoURL else { return }
        let imageAsset = CKAsset(fileURL: photoURL)
        self.setValue(imageAsset, forKey: Constants.locationImageDataKey)
        self.setValue(connection.countDownSinceConnected, forKey: Constants.countDownSinceConnectedKey)
        self.setValue(connection.enabled, forKey: Constants.enabledKey)
        self.setValue(connection.likedConnections, forKey: Constants.likedConnectionsKey)
        self.setValue(connection.passedByConnection, forKey: Constants.passedByConnectionKey)
        self.setValue(connection.uuid, forKey: Constants.uuidKey)
        guard let user = connection.user else { print("There is no relation between this Connection and a User"); return }
        self.setValue(user.userRecordID, forKey: Constants.userKey)
    }
}
















