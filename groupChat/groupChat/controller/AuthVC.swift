//
//  AuthVC.swift
//  groupChat
//
//  Created by Apple on 23/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInWithEmailTapped(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    

    @IBAction func signInWithFBTapped(_ sender: Any) {
    }
    
    @IBAction func signInWithGoogleTapped(_ sender: Any) {
    }
}
