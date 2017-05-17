//
//  Chat.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation
import CloudKit

class Chat: Equatable {
    
    let withWhom: User?
    var messages: [Message]
    var cloudKitRecordID: CKRecordID?
    
    init(withWhom: User?, messages: [Message] = []) {
        self.withWhom = withWhom
        self.messages = messages
    }
    
    init?(record: CKRecord) {
        guard let withWhom = record[Constants.withWhomKey] as? User else { return nil }
        self.withWhom = withWhom
        self.messages = []
        self.cloudKitRecordID = record.recordID
    }
}

extension CKRecord {
    convenience init(chat: Chat) {
        let recordID = chat.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Constants.chatRecordTypeKey, recordID: recordID)
        guard let user = chat.withWhom else { print("There is no relation between this Chat and a User"); return }
        self.setValue(user.userRecordID, forKey: Constants.withWhomKey)
    }
}

func ==(lhs: Chat, rhs: Chat) -> Bool {
    return lhs === rhs
}
