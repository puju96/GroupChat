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
    
}
