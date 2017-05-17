//
//  MessageController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/16/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import Foundation

class MessageController {
    
    static let shared = MessageController()
    
    var messages: [Message] = []
    
    func saveMessage(toChat: Chat, completion: @escaping() -> Void) {
        
        //Save a message pointing to the chat it's in
        
    }
    
    func fetchMessages(forChat: Chat, completion: @escaping() -> Void) {
        
        //Fetch all the messages for a specific chat
        
    }
    
}
