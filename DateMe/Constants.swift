//
//  Constants.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation

struct Constants {
    
    // Segues
    static let toConnectionViewKey = "toConnectionView"
    static let toProfileViewKey = "toProfileSegue"
    static let toMapViewKey = "toMapViewSegue"
    
    // Cell Identifiers
    static let chatTableViewCellKey = "chatCell"
    static let chatCollectionViewCellKey = "matchCell"
    
    // User
    static let userRecordTypeKey = "User"
    static let firstNameKey = "first_name"
    static let lastNameKey = "last_name"
    static let ageKey = "age"
    static let ageRandgeDictionaryKey = "age_range"
    static let minAgeKey = "min"
    static let emailKey = "email"
    static let genderKey = "gender"
    static let chatsKey = "chats"
    static let friendsKey = "friends"
    static let blockedUsersKey = "blockedUsers"
    static let connectionsKey = "connections"
    static let profileImageDataKey = "profileImageData"
    static let appleDefaultUserRefKey = "appleDefaultUserRef"
    static let photoURLKey = "url"
    static let userRecordIDKey = "userRecordID"
    static let pictureDictionaryKey = "picture"
    static let dataDictionaryKey = "data"
    static let facebookImageURLKey = "url"
    
    // Message
    static let messageRecordTypeKey = "Message"
    static let ownerKey = "owner"
    static let textKey = "text"
    static let messageTimestampKey = "timestamp"
    static let isReadKey = "isRead"
    static let chatKey = "chat"
    static let messageRecordIDKey = "messageRecordID"
    
    // Chat
    static let chatRecordTypeKey = "Chat"
    static let withWhomKey = "withWhom"
    static let messagesKey = "messages"
    static let chatRecordIDKey = "chatRecordID"
    
    // Connection
    static let locationImageDataKey = "locationImageData"
    static let countDownSinceConnectedKey = "countDownSinceConnected"
    static let connectionTimestampKey = "timestamp"
    static let userKey = "user"
    static let passedByConnectionKey = "passedByConnection"
    static let likedConnectionsKey = "likedConnections"
    static let uuidKey = "uuid"
    static let enabledKey = "enabled"
    static let connectionRecordIDKey = "recordID"
    static let connectionTypeKey = "Connection"
    
}
