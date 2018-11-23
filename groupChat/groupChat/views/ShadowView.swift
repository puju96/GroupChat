//
//  ShadowView.swift
//  groupChat
//
//  Created by Apple on 23/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//


import UIKit

class ShadowView : UIView{
  
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 7
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.awakeFromNib()
    }
    
}
