//
//  PubNubConnection.swift
//  AntiChatPolin911
//
//  Created by Polina on 17.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import Foundation
import PubNub

class PubNubConnection {
    
    var userName = ""
    var nameChanged = false
    var chan = "antichat_hackathon"
    var chatMessageArray:[ChatMessage] = []
    var usersArray:[String] = []
    
    var mainVC = MainVC()
    
//    func initPubNub(){
//        print("Init Pubnub")
//        
//        let appDel = UIApplication.shared.delegate! as! AppDelegate
//        
//        appDel.client?.unsubscribeFromChannels([chan], withPresence: true)
//        appDel.client?.removeListener(self as! PNObjectEventListener)
//        
//        let config = PNConfiguration( publishKey: "pub-c-8ecaf827-b81c-4d89-abf0-d669cf6da672", subscribeKey: "sub-c-a11d1bc0-ce50-11e5-bcee-0619f8945a4f")
//        config.uuid = userName
//        appDel.client = PubNub.clientWithConfiguration(config)
//        
//        appDel.client?.addListener(self as! PNObjectEventListener)
//        self.joinChannel(chan)
//    }
//    
//    deinit {
//        let appDel = UIApplication.shared.delegate! as! AppDelegate
//        
//        appDel.client?.removeListener(self as! PNObjectEventListener)
//    }
//
//
//
//
//func joinChannel(_ channel: String){
//    let appDel = UIApplication.shared.delegate! as! AppDelegate
//    appDel.client?.subscribeToChannels([channel], withPresence: true)
//    
//    appDel.client?.hereNowForChannel(channel, withCompletion: { (result, status) in
//        
//        for ent in result?.data.uuids as! NSArray{
//            let user = ((ent as! [String:String])["uuid"])!
//            if !self.usersArray.contains(user){
//                self.usersArray.append(user)
//            }
//            
//        }
//        var occ = result?.data.occupancy.stringValue
//        //self.occupancyButton.setTitle(occ, for: UIControlState())
//    })
//    updateHistory()
//    
//    
//    guard let deviceToken   = UserDefaults.standard.object(forKey: "deviceToken") as? Data else {
//        return
//    }
//    print("**********deviceToken is **** \(deviceToken)")
//
//    
//   // appDel.client?.addPushNotifications(onChannels: ["push"], withDevicePushToken: deviceToken, andCompletion: nil)
//    
//}
//    
//    func parseJson(_ anyObj:AnyObject) -> [ChatMessage]{
//        
//        var list:[ChatMessage] = []
//        
//        if  anyObj is [AnyObject] {
//            
//            for jsonMsg in anyObj as! [AnyObject] {
//                let json = jsonMsg["message"] as? NSDictionary
//                // if(json?["type"] as AnyObject? as? String != "Chat"){ continue }
//                let nameJson = (json?["username"] as AnyObject? as? String) ?? "" // to get rid of null
//                let textJson  =  (json?["message"]  as AnyObject? as? String) ?? ""
//                let timeJson  =  (json?["time"]  as AnyObject? as? String) ?? ""
//            
//                
//                list.append(ChatMessage(username: nameJson, message: textJson, time: timeJson))
//            }
//            mainVC.chatTableView.reloadData()
//            
//        }
//        
//        return list
//        
//    }
//    
//    func updateHistory(){
//        
//        let appDel = UIApplication.shared.delegate! as! AppDelegate
//        
//        appDel.client?.historyForChannel(chan, start: nil, end: nil, includeTimeToken: true, withCompletion: { (result, status) in
//            
//            print("!!!!!!!!!!!!\(result)")
//            self.chatMessageArray = self.parseJson(result!.data.messages as AnyObject)
//            self.updateTableview()
//            
//        })
//    }
//    func updateTableview(){
//        mainVC.chatTableView.reloadData()
//        
//        
//        if mainVC.chatTableView.contentSize.height > mainVC.chatTableView.frame.size.height {
//            mainVC.chatTableView.scrollToRow(at: IndexPath(row: chatMessageArray.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
//        }
//    }
//    
//    
    


}


