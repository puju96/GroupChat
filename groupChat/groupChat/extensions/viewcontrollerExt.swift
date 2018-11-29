//
//  viewcontrollerExt.swift
//  groupChat
//
//  Created by Apple on 29/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewcontrollerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition , forKey: kCATransition)
        
        present(viewcontrollerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition,forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
