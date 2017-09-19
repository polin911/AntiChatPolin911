//
//  ChatMessage.swift
//  AntiChatPolin911
//
//  Created by Polina on 16.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import Foundation

class ChatMessage: NSObject {
    
    var username: String
    var message : String
    var time    : String

    
    init(username: String, message: String, time: String) {
        self.username = username
        self.message  = message
        self.time     = time
  
    }
    
   
}
class ChatMessage2: NSObject {
    
    var username: String
    var message : String
    var time    : String

    
    init(username: String, message: String, time: String) {
        self.username = username
        self.message  = message
        self.time     = time

    }
    
    
}
