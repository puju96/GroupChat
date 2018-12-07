//
//  meCell.swift
//  groupChat
//
//  Created by Apple on 30/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class meCell: UITableViewCell {

    @IBOutlet weak var myMsg: UILabel!
   
    func configureCell(message : String) {
        self.myMsg.text = message
    }

}
