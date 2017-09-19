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
var chatMesArray2:[ChatMessage2] = []



var userName    = ""
var nameChanged = false
var chan        = "antichat_hackathon"
var imgName     = ""

func chatMessageToDictionary(_ chatmessage: ChatMessage) -> [String: NSString]{
    return [
        "username": NSString(string: chatmessage.username),
        "message": NSString(string: chatmessage.message),
        "time": NSString(string: chatmessage.time)
    ]
}

//func chatMessageToDictionary2(_ chatmessage: ChatMessage2) -> [String: NSString]{
//    return [
//        "name": NSString(string: chatmessage.username),
//        "text": NSString(string: chatmessage.message)
//    ]
//}
