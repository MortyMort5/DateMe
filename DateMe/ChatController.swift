//
//  ChatController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/16/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation

class ChatController {
    
    static let shared = ChatController()
    
    var chats: [Chat] = []
    
    func saveChat(completion: @escaping() -> Void) {
        
        //User hit's one of the people in the collection view that they have matched with call this function
        
    }
    
    func fetchChats(forUser: User, completion: @escaping() -> Void) {
        
        //Fetch all chats for user from cloudkit
        
    }
    
    func deleteChat(chat: Chat, completion: @escaping() -> Void) {
        
        //Delete a chat from tableView
        
    }
    
    
    
    
}
