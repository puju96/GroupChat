//
//  AuthVC.swift
//  groupChat
//
//  Created by Apple on 23/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthVC: UIViewController , GIDSignInUIDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
     

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func signInWithEmailTapped(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    

    @IBAction func signInWithFBTapped(_ sender: Any) {
    }
    
    @IBAction func signInWithGoogleTapped(_ sender: Any) {
//
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.frame = CGRect(x: 120, y: 200, width: view.frame.width - 240, height: 50)
        view.addSubview(googleSignInButton)
        
    }
}
