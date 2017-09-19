//
//  WelcomeVC.swift
//  AntiChatPolin911
//
//  Created by Polina on 19.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    var menuItems = ["Имя", "Чат"]
    var imgName = ["1.png", "2.png", "3.png","4.png", "5.png", "6.png","7.png", "8.png","9.png", "10.png"]
    
    
    @IBOutlet var tableViewNameChat: UITableView!
    @IBOutlet var viewCollectionImg: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadView()
        // Do any additional setup after loading the view.
    }
    func uploadView() {
        tableViewNameChat.delegate   = self
        tableViewNameChat.dataSource = self
        viewCollectionImg.dataSource = self
        viewCollectionImg.delegate   = self
    }
/////////////////MARK: AlertFunction
    func changeNameModal() {
        
        var loginAlert:UIAlertController = UIAlertController(title: "Имя", message: "Пожалуйста введите свое имя или ник", preferredStyle: UIAlertControllerStyle.alert)
        
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
                self.changeNameModal()
            }
            else{
                print("******changing UUID to \(userName)")
                nameChanged = true
            }
        }))
        
        self.present(loginAlert, animated: true, completion: nil)
    }
    
    func changeChatModal() {
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        appDel.client?.unsubscribeFromChannels([chan], withPresence: true)
        
        let loginAlert:UIAlertController = UIAlertController(title: "Телепортироваться в другой чат", message: "Введите название чатп", preferredStyle: UIAlertControllerStyle.alert)
        
        loginAlert.addTextField(configurationHandler: {
            textfield in
            textfield.placeholder = "подписать меня на чат: _____"
        })
        
        loginAlert.addAction(UIAlertAction(title: "Go", style: UIAlertActionStyle.default, handler: {alertAction in
            let textFields:NSArray = loginAlert.textFields! as NSArray
            let usernameTextField:UITextField = textFields.object(at: 0) as! UITextField
            chan = usernameTextField.text!
            if(chan == ""){
                self.changeChatModal()
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
extension WelcomeVC: UITableViewDelegate {
    
}
extension WelcomeVC: UICollectionViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            changeNameModal()
        }
        if indexPath.row == 1 {
            changeChatModal()
        }
    }
    
}

extension WelcomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewNameChat.dequeueReusableCell(withIdentifier: "nameChatCell", for: indexPath) as! NameChatCell
        
        cell.nameChatLb.text = menuItems[indexPath.row]
        return cell
    }
}

extension WelcomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgName.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = viewCollectionImg.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! imgCollectionCell
       // cell.imgCollection.image = UIImage(named: imgName[indexPath.row])
        
        return cell
    }
    
}
