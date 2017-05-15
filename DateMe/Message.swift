//
//  Message.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CloudKit

class Message: Equatable {
    
    var owner: User?
    var text: String
    let timestamp: Date
    var isRead: Bool
    let chat: Chat?
    var cloudKitRecordID: CKRecordID?
    
    init(owner: User?, text: String, timestamp: Date = Date(), isRead: Bool, chat: Chat?) {
        self.owner = owner
        self.text = text
        self.timestamp = timestamp
        self.isRead = isRead
        self.chat = chat
    }
    
    init?(record: CKRecord) {
        guard let owner = record[Constants.ownerKey] as? User,
            let text = record[Constants.textKey] as? String,
            let timestamp = record[Constants.timestampKey] as? Date,
            let isRead = record[Constants.isReadKey] as? Bool,
            let chat = record[Constants.chatKey] as? Chat else { return nil }
        self.owner = owner
        self.text = text
        self.timestamp = timestamp
        self.isRead = isRead
        self.chat = chat
        self.cloudKitRecordID = record.recordID
    }
}

extension CKRecord {
    convenience init(message: Message) {
        let recordID = message.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Constants.messageRecordTypeKey, recordID: recordID)
        self.setValue(message.owner, forKey: Constants.ownerKey)
        self.setValue(message.text, forKey: Constants.textKey)
        self.setValue(message.timestamp, forKey: Constants.timestampKey)
        self.setValue(message.isRead, forKey: Constants.isReadKey)
        self.setValue(message.chat, forKey: Constants.chatKey)
    }
}

func ==(lhs: Message, rhs: Message) -> Bool {
    return lhs === rhs
}
