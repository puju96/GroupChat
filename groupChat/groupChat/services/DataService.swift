//
//  DataService.swift
//  groupChat
//
//  Created by Apple on 22/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Firebase

  let DB_REF = Database.database().reference()
class DataService {
    static let instance = DataService()
    
    private var REF_DB = DB_REF
    private var REF_USERS = DB_REF.child("users")
    private var REF_FEED = DB_REF.child("feed")
    private var REF_GROUPS = DB_REF.child("group")
    
    var ref_db : DatabaseReference {
        return REF_DB
    }
    
    var ref_users : DatabaseReference {
        return REF_USERS
    }
    
    var ref_feed : DatabaseReference{
        return REF_FEED
    }
    var ref_groups : DatabaseReference{
        return REF_GROUPS
    }
    
    func createUserDB(uid:String , userData: Dictionary<String,Any>) {
        ref_users.child(uid).updateChildValues(userData)
    }
    
    func getUserName(forUID uid: String , handler: @escaping (_ userName:String) -> ()) {
        ref_users.observeSingleEvent(of: .value) { (userDataSnapShot) in
            guard let userDataSnapShot = userDataSnapShot.children.allObjects as? [DataSnapshot] else{
                return
            }
            for user in userDataSnapShot {
                if user.key == uid{
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
        
    }
    
    func uploadPost(withMessage message : String, forUID uid: String,forGropuKey groupkey: String?, sendComplete : @escaping (_ status : Bool) ->()){
        if groupkey != nil {
            // send group post
        }
        else{
            ref_feed.childByAutoId().updateChildValues(["content" : message, "User" : uid])
        }
    }
    
    func getAllMessages(handler : @escaping (_ messages: [Message]) ->()) {
        
        var msgArray = [Message]()
        ref_feed.observeSingleEvent(of: .value) { (feeddatasnapshot) in
            guard let feeddatasnapshot = feeddatasnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in feeddatasnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "User").value as! String
                let message = Message(content: content, senderId: senderId)
                msgArray.append(message)
            }
            
            handler(msgArray)
        }
    }
    
}

