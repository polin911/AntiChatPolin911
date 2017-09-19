//
//  MainVC.swift
//  AntiChatPolin911
//
//  Created by Polina on 16.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import UIKit
import PubNub

class MainVC: UIViewController, PNObjectEventListener, MenuTransitionManagerDelegate {

    @IBOutlet var chatNameLbl: UILabel!
    @IBOutlet var chatTableView: UITableView!
    
    var menuTransitionManager = MenuTransitionManager()
    var kPreferredTextFieldToKeyboardOffset: CGFloat = 70.0
    var keyboardFrame: CGRect = CGRect.null
    var keyboardIsShowing: Bool = false
    
    @IBOutlet var messageTxtField: UITextField!
    @IBOutlet var senderBtn: UIButton!
    
    var introModalDidDisplay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = chan
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        
//        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        
//        for subview in self.view.subviews
//        {
//            if (subview.isKind(of: UITextField.self))
//            {
//                let textField = subview as! UITextField
//                textField.addTarget(self, action: #selector(MainVC.textFieldDidReturn(_:)), for: UIControlEvents.editingDidEndOnExit)
//                
//                textField.addTarget(self, action: #selector(UITextFieldDelegate.textFieldDidBeginEditing(_:)), for: UIControlEvents.editingDidBegin)
//                
//            }
//        }
//        
//        if(userName != ""){
//            joinChannel(chan)
//        }
//        
//        if (nameChanged) { // Name was Changed in the change name view
//            self.initPubNub()
//            nameChanged = false
//        }
        
    }
    


    func updateView() {
        self.chatTableView.delegate   = self
        self.chatTableView.dataSource = self
        updateTableview()
        //showIntroModal()
    }
    ///////////////////////////////MARK: PubNubConnection

    
    //    func returnViewToInitialFrame()
//    {
//        let initialViewRect: CGRect = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        
//        if (!initialViewRect.equalTo(self.view.frame))
//        {
//            UIView.animate(withDuration: 0.2, animations: {
//                self.view.frame = initialViewRect
//            });
//        }
//    }
//    
//    func keyboardWillShow(_ notification: Notification)
//    {
//        self.keyboardIsShowing = true
//        
//        if let info = notification.userInfo {
//            self.keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//            self.arrangeViewOffsetFromKeyboard()
//        }
//        
//    }
//    
//    func keyboardWillHide(_ notification: Notification)
//    {
//        self.keyboardIsShowing = false
//        
//        self.returnViewToInitialFrame()
//    }
//    
//    
//    func showIntroModal() {
//        if (!introModalDidDisplay) {
//            
//            let loginAlert:UIAlertController = UIAlertController(title: "New User", message: "Please enter your name", preferredStyle: UIAlertControllerStyle.alert)
//            
//            loginAlert.addTextField(configurationHandler: {
//                textfield in
//                textfield.placeholder = "What is your name?"
//            })
//            
//            loginAlert.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.default, handler: {alertAction in
//                let textFields:NSArray = loginAlert.textFields! as NSArray
//                let usernameTextField:UITextField = textFields.object(at: 0) as! UITextField
//                userName = usernameTextField.text!
//                userName = userName.replacingOccurrences(of: " ", with: "_", options: NSString.CompareOptions.literal, range: nil)
//                if(userName == ""){
//                    self.showIntroModal()
//                }
//                else{
//                    self.introModalDidDisplay = true
//                    self.initPubNub()
//                }
//                
//            }))
//            
//            self.present(loginAlert, animated: true, completion: nil)
//            
//        }
//        
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuTableViewController = segue.destination as! MenuTableViewController
        menuTableViewController.transitioningDelegate = self.menuTransitionManager
        self.menuTransitionManager.delegate = self
        
    }

    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initPubNub(){
        print("Init Pubnub")
        
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        
        appDel.client?.unsubscribeFromChannels([chan], withPresence: true)
        appDel.client?.removeListener(self)
        
        let config = PNConfiguration( publishKey: "pub-c-8ecaf827-b81c-4d89-abf0-d669cf6da672", subscribeKey: "sub-c-a11d1bc0-ce50-11e5-bcee-0619f8945a4f")
        config.uuid = userName
        appDel.client = PubNub.clientWithConfiguration(config)
        
        appDel.client?.addListener(self)
        self.joinChannel(chan)
    }
    
    deinit {
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        
        appDel.client?.removeListener(self)
    }
    
    
    
    
    func joinChannel(_ channel: String){
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        appDel.client?.subscribeToChannels([channel], withPresence: true)
        
        appDel.client?.hereNowForChannel(channel, withCompletion: { (result, status) in
            
            for ent in result?.data.uuids as! NSArray{
                let user = ((ent as! [String:String])["uuid"])!
                if !usersArray.contains(user){
                    usersArray.append(user)
                }
                
            }
            var occ = result?.data.occupancy.stringValue
            //self.occupancyButton.setTitle(occ, for: UIControlState())
        })
        updateHistory()
        
        
        guard let deviceToken   = UserDefaults.standard.object(forKey: "deviceToken") as? Data else {
            return
        }
        print("**********deviceToken is **** \(deviceToken)")
        
        
        // appDel.client?.addPushNotifications(onChannels: ["push"], withDevicePushToken: deviceToken, andCompletion: nil)
        
    }
    
    func parseJson(_ anyObj:AnyObject) -> [ChatMessage]{
        
        var list:[ChatMessage] = []
        
        if  anyObj is [AnyObject] {
            
            for jsonMsg in anyObj as! [AnyObject] {
                let json = jsonMsg["message"] as? NSDictionary
                // if(json?["type"] as AnyObject? as? String != "Chat"){ continue }
                let usernameJson = (json?["username"] as AnyObject? as? String) ?? "" // to get rid of null
                let namesJson = (json?["name"] as AnyObject? as? String) ?? ""
                let textJson  =  (json?["message"]  as AnyObject? as? String) ?? ""
                let timeJson  =  (json?["time"]  as AnyObject? as? String) ?? ""
                
                
                list.append(ChatMessage(username: usernameJson, message: textJson, time: timeJson))
            }
           chatTableView.reloadData()
            
        }
        
        return list
        
    }
    
    func updateHistory(){
        
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        
        appDel.client?.historyForChannel(chan, start: nil, end: nil, includeTimeToken: true, withCompletion: { (result, status) in
             print("!!!!!!!!!Status: \(result)")
            
           
            chatMesArray = self.parseJson(result!.data.messages as AnyObject)
            self.updateTableview()
            
        })
    }
    func updateTableview(){
        self.chatTableView.reloadData()
        
        
        if self.chatTableView.contentSize.height > self.chatTableView.frame.size.height {
            chatTableView.scrollToRow(at: IndexPath(row: chatMesArray.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
    func updateChat(){
        chatTableView.reloadData()
        
        let numberOfSections = chatTableView.numberOfSections
        let numberOfRows = chatTableView.numberOfRows(inSection: numberOfSections-1)
        
        if numberOfRows > 0 {
            let indexPath = IndexPath(row:numberOfRows - 1, section:numberOfSections - 1)
            
            //IndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
            chatTableView.scrollToRow(at: indexPath, at: .bottom,
                                         animated: true)
        }
        
    }
    
    /////////////////////MARK: Upload Message
    
    
    /////Mark: clientPubNub
    
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        print("******didReceiveMessage*****")
        print("from client!!!!!!!!!!!!!!!!!!!!!!!\(message.data)")
        print("*******UUID from message IS \(message.uuid)")
        
        var stringData  = message.data.message as! NSDictionary
        var stringName  = stringData["username"] as! String
        var stringText  = stringData["message"] as! String
        var stringTime  = stringData["time"] as! String
        
        
        var newMessage = ChatMessage(username: stringName, message: stringText, time: stringTime)
        
        chatMesArray.append(newMessage)
        updateChat()
        
    }
    
    func client(_ client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
        print("******didReceivePresenceEvent*****")
        print(event.data)
        print("*******UUID from presence IS \(event.uuid)")
        
        
        var occ = event.data.presence.occupancy.stringValue
        //occupancyButton.setTitle(occ, for: UIControlState())
        
        
        
        switch event.data.presenceEvent{
        case "join":
            var pubChat = ChatMessage(username: "", message: "\(event.data.presence.uuid?.uppercased())", time: getTime())
            
            chatMesArray.append(pubChat)
            
        case "leave":
            var pubChat = ChatMessage(username: "", message: "\(event.data.presence.uuid?.uppercased()) left the chat", time: getTime())
            chatMesArray.append(pubChat)
            
        case "timeout":
            var pubChat = ChatMessage(username: "", message: "\(event.data.presence.uuid?.uppercased()) has timed out", time: getTime())
            chatMesArray.append(pubChat)
            
        default:
            var pubChat = ChatMessage(username: "", message: "\(event.data.presence.uuid?.uppercased()) has timed out", time: getTime())
            chatMesArray.append(pubChat)
            
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
            let pubChat = ChatMessage(username: userName, message: messageTxtField.text!, time: getTime())
            
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
        
        cell.chatTxtLbl.text  = chatMesArray[indexPath.row].message
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMesArray.count
    }
}