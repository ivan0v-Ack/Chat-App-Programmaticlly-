//
//  Service.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/20/21.
//

import Foundation
import Firebase


struct Service {
    static func fetchUsers(completion: @escaping([User]) -> Void){
        var usersArray = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach{ document in
                let dictionary = document.data()
               let user = User(dictionary: dictionary)
                usersArray.append(user)
             }
            completion(usersArray)
        }
        
    }
}
