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
    var countDownSinceConnected: TimeInterval
    let timestamp: Date
    var user: User?
    let uuid: String
    var enabled: Bool
    var passedByConnection: CKReference?
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
    
    func dictionaryRepresentation() -> [String: Any] {
        return [
            Constants.countDownSinceConnectedKey: countDownSinceConnected,
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
    
    
    
}




















