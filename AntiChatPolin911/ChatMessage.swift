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
    var text : String
    var time    : String
    var image   : String
    
    var imgSticker: String

    
    init(username: String, text: String, time: String, image: String, imgSticker: String) {
        self.username = username
        self.text     = text
        self.time     = time
        self.image    = image
        self.imgSticker = imgSticker
  
    }
    
   
}

