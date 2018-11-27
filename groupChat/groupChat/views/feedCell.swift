//
//  feedCell.swift
//  groupChat
//
//  Created by Apple on 26/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {
    
    @IBOutlet weak var msgContentLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func configurCell(profileImage : UIImage, email: String, content: String){
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        self.msgContentLbl.text = content
        
    }

}
