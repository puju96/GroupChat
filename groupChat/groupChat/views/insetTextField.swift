//
//  insetTextField.swift
//  groupChat
//
//  Created by Apple on 23/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class insetTextField: UITextField {

   private var padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
   
  override func awakeFromNib() {
    let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
    
    self.attributedPlaceholder = placeholder
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
   
    
    
}
