//
//  UsersVC.swift
//  AntiChatPolin911
//
//  Created by Polina on 19.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
    @IBOutlet var usersTableView: UITableView!

    var users = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateView()
        // Do any additional setup after loading the view.
    }
    func updateView() {
        usersTableView.delegate   = self
        usersTableView.dataSource = self
    }


    func showUsers() -> [String]{
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        appDel.client?.subscribeToChannels([chan], withPresence: true)
        
        appDel.client?.hereNowForChannel(chan, withCompletion: { (result, status) in
            
            for ent in result?.data.uuids as! NSArray{
                let user = ((ent as! [String:String])["uuid"])!
                if !usersArray.contains(user){
                    usersArray.append(user)
                }
                
            }
            //var occ = result?.data.occupancy.stringValue
            //self.occupancyButton.setTitle(occ, for: UIControlState())
        })
        return usersArray
    }
}
extension UsersVC: UITableViewDelegate {
    
}

extension UsersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showUsers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath) as! UsersCell
        cell.userName.text = showUsers()[indexPath.row]
        
        return cell
    }
}
