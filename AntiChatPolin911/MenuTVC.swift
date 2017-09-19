//
//  MenuTVC.swift
//  AntiChatPolin911
//
//  Created by Polina on 17.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var menuItems = ["Change Channel", "Change Name"]
    //let blogSegueIdentifier = "ShowBlogSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(menuItems[indexPath.row] as String)
        
        if(indexPath.row == 0){
            showChannelModal()
        }
        
        if(indexPath.row == 1){
            showNameModal()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeCell", for: indexPath) as! ChageUserCell
       cell.changeLbl.text = menuItems[indexPath.row]
        return cell
    }
    

    func showNameModal() {
        
        var loginAlert:UIAlertController = UIAlertController(title: "Change Name", message: "Please enter your new name", preferredStyle: UIAlertControllerStyle.alert)
        
        loginAlert.addTextField(configurationHandler: {
            textfield in
            textfield.placeholder = "What is your name?"
        })
        
        loginAlert.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.default, handler: {alertAction in
            let textFields:NSArray = loginAlert.textFields! as NSArray
            let usernameTextField:UITextField = textFields.object(at: 0) as! UITextField
            userName = usernameTextField.text!
            userName = userName.replacingOccurrences(of: " ", with: "_", options: NSString.CompareOptions.literal, range: nil)
            if(userName == ""){
                self.showNameModal()
            }
            else{
                print("******changing UUID to \(userName)")
                nameChanged = true
            }
        }))
        
        self.present(loginAlert, animated: true, completion: nil)
    }
    
    
    func showChannelModal() {
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        appDel.client?.unsubscribeFromChannels([chan], withPresence: true)
        
        let loginAlert:UIAlertController = UIAlertController(title: "Change Channel", message: "Please enter Channel name", preferredStyle: UIAlertControllerStyle.alert)
        
        loginAlert.addTextField(configurationHandler: {
            textfield in
            textfield.placeholder = "Subscribe me to channel: _____"
        })
        
        loginAlert.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.default, handler: {alertAction in
            let textFields:NSArray = loginAlert.textFields! as NSArray
            let usernameTextField:UITextField = textFields.object(at: 0) as! UITextField
            chan = usernameTextField.text!
            if(chan == ""){
                self.showChannelModal()
            }
            else{
                chatMesArray = []
                usersArray = []
                appDel.client?.subscribeToChannels([chan], withPresence: true)
            }
        }))
        
        self.present(loginAlert, animated: true, completion: nil)
    }
    
    
    
}
