//
//  userCell.swift
//  groupChat
//
//  Created by Apple on 27/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var checkImg: UIImageView!
    
    
    
    func configureCell(ProfileImg: UIImage, email:String, isSelected : Bool ){
        self.profileImg.image = ProfileImg
        self.emailLbl.text = email
        if isSelected {
            self.checkImg.isHidden = false
        }else{
            self.checkImg.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            checkImg.isHidden = false
        }else{
            checkImg.isHidden = true
        }
    }

}
