//
//  groupFeedCell.swift
//  groupChat
//
//  Created by Apple on 28/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class groupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var emailTxt: UILabel!
    
    @IBOutlet weak var msgTxt: UILabel!
    
    func configureCell(profileImg : UIImage, email: String, message: String){
        self.profileImg.image = profileImg
        self.emailTxt.text = email
        self.msgTxt.text = message
    }
    
}
