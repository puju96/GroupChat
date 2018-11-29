//
//  groupCell.swift
//  groupChat
//
//  Created by Apple on 28/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class groupCell: UITableViewCell {
    
    @IBOutlet weak var titleTxt: UILabel!
    
    @IBOutlet weak var descTxt: UILabel!
    
    @IBOutlet weak var memberCountLbl: UILabel!
   
    func configureCell(withTitle title: String , andwithDescription desc: String, memberCount : Int){
        self.titleTxt.text = title
        self.descTxt.text = desc
        self.memberCountLbl.text = "\(memberCount) Members"
        
        
    }
}
