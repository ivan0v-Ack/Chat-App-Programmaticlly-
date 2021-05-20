//
//  User.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/20/21.
//

import Foundation


struct User {
    let uid: String
    let prfileImageUrl: String
    let username: String
    let fullname: String
    let email: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.prfileImageUrl = dictionary["profileImageURl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
