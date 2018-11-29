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
            ref_groups.child(groupkey!).child("message").childByAutoId().updateChildValues(["content" : message, "User" : uid])
            sendComplete(true)
        }
        else{
            ref_feed.childByAutoId().updateChildValues(["content" : message, "User" : uid])
            sendComplete(true)
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
    
    func getMsgOfDesiredGroup(desiredGrp : Group , handler: @escaping (_ msgArray: [Message]) ->()) {
        var msgArray = [Message]()
        ref_groups.child(desiredGrp.Grpkey).child("message").observeSingleEvent(of: .value) { (grpSnapShot) in
            guard let grpSnapShot = grpSnapShot.children.allObjects as? [DataSnapshot] else{ return }
                for grpmsg in grpSnapShot {
                    let content = grpmsg.childSnapshot(forPath: "content").value as! String
                    let senderId = grpmsg.childSnapshot(forPath: "User").value as! String
                    let grpmessage = Message(content: content, senderId: senderId)
                    msgArray.append(grpmessage)
                }
            handler(msgArray)
            }
        }
        
    
    
    
    func getEmails(forSearchQuery query: String , handler : @escaping (_ emailArray : [String]) ->()) {
        var emailArray = [String]()
        
        ref_users.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for user in userSnapShot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) {
                    emailArray.append(email)
                }
            }
             handler(emailArray)
        }
       
    }
    
    func getIds(forusername username:[String], handler: @escaping (_ userNames : [String]) ->()){
        var usernames = [String]()
        ref_users.observeSingleEvent(of: .value) { (userSnapShot) in
            
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapShot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if username.contains(email){
                    usernames.append(user.key)
                }
                
            }
           handler(usernames)
        }
        
        
    }
    
    
    func getEmailfor(group : Group , handler : @escaping (_ emailArray:[String]) ->()){
        var emailArray = [String]()
        ref_users.observeSingleEvent(of: .value) { (userSnapShot) in
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapShot {
                if group.GrpMembers.contains(user.key) {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func createGroup(withTitle title: String, andDescription desc:String, forUserIds ids : [String] , CreateGroup : @escaping (_ isCreatedGroup:Bool) ->()) {
        
        ref_groups.childByAutoId().updateChildValues(["title" : title , "description": desc , "memberIds" : ids])
        CreateGroup(true)
    }
    
    func getallGroups(handler: @escaping (_ groupArray : [Group]) ->()) {
        var grpArray = [Group]()
        ref_groups.observeSingleEvent(of: .value) { (groupSnapShot) in
            guard let groupSnapShot = groupSnapShot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapShot {
                let memberids = group.childSnapshot(forPath: "memberIds").value as! [String]
                
                if memberids.contains((Auth.auth().currentUser?.uid)!){
                let title = group.childSnapshot(forPath: "title").value as! String
                let desc = group.childSnapshot(forPath: "description").value as! String
                
                let memberCount = memberids.count
                
                let group = Group(title: title, desc: desc, members: memberids, grpKey: group.key, NoOfmembers: memberCount)
                grpArray.append(group)
            }
            }
            handler(grpArray)
        }
        
        
    }
    
}

