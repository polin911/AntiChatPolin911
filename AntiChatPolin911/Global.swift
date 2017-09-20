//
//  Global.swift
//  AntiChatPolin911
//
//  Created by Polina on 17.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import Foundation
var chatMesArray :[ChatMessage]  = []
var usersArray   :[String]       = []




var userName    = ""
var nameChanged = false
var chan        = "antichat_hackathon"
var imgName     = "1.png"

func chatMessageToDictionary(_ chatmessage: ChatMessage) -> [String: NSString]{
    return [
        "username": NSString(string: chatmessage.username),
        "text"    : NSString(string: chatmessage.text),
        "time"    : NSString(string: chatmessage.time),
        "image"   : NSString(string: chatmessage.image)
    ]
}


