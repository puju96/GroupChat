//
//  LoginVC.swift
//  groupChat
//
//  Created by Apple on 23/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwdTxt: insetTextField!
    @IBOutlet weak var emailTxt: insetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwdTxt.delegate = self
        emailTxt.delegate = self
        
        }



    @IBAction func signInBtnTapped(_ sender: Any) {
        
        if emailTxt.text != nil && passwdTxt.text != nil {
            AuthService.instance.loginUser(withemail: emailTxt.text!, withpassword: passwdTxt.text!) { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print(String(describing: error?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withemail: self.emailTxt.text!, withpassword: self.passwdTxt.text!, userCreationComplete: { (success, error) in
                    if success {
                        AuthService.instance.loginUser(withemail: self.emailTxt.text!, withpassword: self.passwdTxt.text!, loginComplete: { (success, nil) in
                             print("user successfully registered")
                            self.dismiss(animated: true, completion: nil)
                            
                        })
                       
                    }else{
                        print(String(describing: error?.localizedDescription))
                    }
                })
            }
        }
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
extension LoginVC : UITextFieldDelegate {
    
}
