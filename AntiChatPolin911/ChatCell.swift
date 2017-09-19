//
//  ChatCell.swift
//  AntiChatPolin911
//
//  Created by Polina on 16.09.17.
//  Copyright © 2017 Polina. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet var chatNameLbl: UILabel!
    @IBOutlet var chatTxtLbl: UILabel!
    @IBOutlet var chatImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
