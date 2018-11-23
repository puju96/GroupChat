//
//  AuthService.swift
//  groupChat
//
//  Created by Apple on 23/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import FirebaseAuth


class AuthService {
    
    static let instance = AuthService()
    
    func registerUser(withemail email : String , withpassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error : Error?) ->())
    {
        Auth.auth().createUser(withEmail: email, password: password) { (Authresult, error) in
            guard let user = Authresult?.user else {
                userCreationComplete(false,error)
             return
        }
          
            let userData = ["provider": user.providerID , "email": user.email]
            DataService.instance.createUserDB(uid: user.uid, userData: userData)
            userCreationComplete(true,nil)
        
            }
          }
    

    func loginUser(withemail email : String , withpassword password: String, loginComplete: @escaping (_ status: Bool, _ error : Error?) ->())
    {
        Auth.auth().signIn(withEmail: email, password: password) { (Authresult, error) in
            if error != nil{
                loginComplete(false,error)
                return
            }
            
            loginComplete(true,nil)
        }
    }

}
