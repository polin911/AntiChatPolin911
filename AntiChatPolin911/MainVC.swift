//
//  MainVC.swift
//  AntiChatPolin911
//
//  Created by Polina on 16.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import UIKit
import PubNub

class MainVC: UIViewController, PNObjectEventListener {

    @IBOutlet var segment: UISegmentedControl!
    
    @IBOutlet var userImg: UIImageView!
    
    @IBOutlet var chatNameLbl: UILabel!
    @IBOutlet var chatTableView: UITableView!
    
   // var menuTransitionManager = MenuTransitionManager()
    var kPreferredTextFieldToKeyboardOffset: CGFloat = 70.0
    var keyboardFrame: CGRect = CGRect.null
    var keyboardIsShowing: Bool = false
    
    @IBOutlet var messageTxtField: UITextField!
    @IBOutlet var senderBtn: UIButton!
    
    var introModalDidDisplay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = chan
        updateView()
    }
    


    func updateView() {
        self.chatTableView.delegate   = self
        self.chatTableView.dataSource = self
        initPubNub()
        updateTableview()
        userImg.image = UIImage(named: imgName)

    }
    ///////////////////////////////MARK: PubNubConnection

    
    /////////////////////MARK: Upload Message
    
    
    /////Mark: clientPubNub
    
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        print("******didReceiveMessage*****")
        print("from client!!!!!!!!!!!!!!!!!!!!!!!\(message.data)")
        print("*******UUID from message IS \(message.uuid)")
        
        var stringData  = message.data.message as? NSDictionary

        
        var stringName  = stringData?["username"] as? String ?? ""
        var stringText  = stringData?["text"] as? String ?? ""
        var stringTime  = stringData?["time"] as? String ?? ""
        var stringImg   = stringData?["image"] as? String ?? ""
        
        
        var newMessage = ChatMessage(username: stringName, text: stringText, time: stringTime, image: stringImg)
        
        chatMesArray.append(newMessage)
        updateChat()
        
    }
    
    func client(_ client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
        print("******didReceivePresenceEvent*****")
        print(event.data)
        print("*******UUID from presence IS \(event.uuid)")
        
        
        var occ = event.data.presence.occupancy.stringValue
        //occupancyButton.setTitle(occ, for: UIControlState())
        segment.setTitle("Участников: \(occ)", forSegmentAt: 1)
        
        
        
        switch event.data.presenceEvent{
        case "join":
            var pubChat = ChatMessage(username:"", text: "\(userName) присоединился к нам!", time: getTime(), image: "")
            
            chatMesArray.append(pubChat)
            
        case "leave":
            var pubChat = ChatMessage(username: "", text: "\(event.data.presence.uuid?.uppercased()) left the chat", time: getTime(),image: "")
            chatMesArray.append(pubChat)
            
//        case "timeout":
//            var pubChat = ChatMessage(username: "", message: "\(event.data.presence.uuid?.uppercased()) - \(userName) покинул нас", time: getTime(),image: "")
//            chatMesArray.append(pubChat)
            
        default:
            var pubChat = ChatMessage(username: "", text: "\(event.data.presence.uuid?.uppercased()) - \(userName) покинул нас", time: getTime(),image: "")
            //chatMesArray.append(pubChat)
            
        }
        
        if (event.data.presenceEvent == "join"){
            //Add to array
            if !(usersArray.contains(event.data.presence.uuid!)){
                usersArray.append(event.data.presence.uuid!)
            }
        }
        else {
            // Check if in array, only delete if they are
            if (usersArray.contains(event.data.presence.uuid!)){
                usersArray = usersArray.filter{$0 != event.data.presence.uuid}
            }
            
        }
        
        updateChat()
        
        
    }
    
/////////
    func getTime() -> String{
        let currentDate = Date()  // -  get the current date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a" //format style to look like 00:00 am/pm
        let dateString = dateFormatter.string(from: currentDate)
        
        return dateString
    }
    
    @IBAction func buttonNamePressed(_ sender: Any) {
        initPubNub()
        print("pressed")
        updateTableview()
    }
    
    @IBAction func senderBtnPressed(_ sender: Any) {
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        
        let message = messageTxtField.text
        if(message == "") {return}
        else{
            let pubChat = ChatMessage(username: userName, text: messageTxtField.text!, time: getTime(), image: imgName)
            
            let newDict = chatMessageToDictionary(pubChat)
            
            appDel.client?.publish(newDict, toChannel: chan, compressed: true, withCompletion: nil)
            
            messageTxtField.text = nil
            updateTableview()
        }
    }
    

}


extension MainVC: UITableViewDelegate {
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
      
        cell.chatNameLbl.text = chatMesArray[indexPath.row].username
        cell.chatTxtLbl.text  = chatMesArray[indexPath.row].text
        cell.chatImage.image  = UIImage(named:(chatMesArray[indexPath.row].image))
        cell.timeLbl.text     = chatMesArray[indexPath.row].time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMesArray.count
    }
}
