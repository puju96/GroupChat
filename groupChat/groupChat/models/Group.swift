//
//  Group.swift
//  groupChat
//
//  Created by Apple on 28/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class Group {
    private var grpTitle : String
    private var grpDesc : String
    private var memberCount : Int
    private var key : String
    private var members : [String]
    
    var GrpTitle : String {
        return grpTitle
    }
    var GrpDesc : String {
        return grpDesc
    }
    var Grpkey : String {
        return key
    }
    var GrpMembers : [String] {
        return members
    }
    var GrpMemberCount : Int {
        return memberCount
    }
    
    init(title : String, desc: String, members:[String], grpKey: String, NoOfmembers : Int){
    self.grpTitle = title
        self.grpDesc = desc
        self.members = members
        self.key = grpKey
        self.memberCount = NoOfmembers
        
    }
}
