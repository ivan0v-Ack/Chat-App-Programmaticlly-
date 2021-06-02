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
        COLLECTION_USERS.getDocuments { snapshot, error in
            snapshot?.documents.forEach{ document in
                let dictionary = document.data()
               let user = User(dictionary: dictionary)
                usersArray.append(user)
             }
            completion(usersArray)
        }
        
    }
    
    static func fetchUser(withUID uid: String, completion: @escaping(User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            let dictionary = snapshot?.data()
            completion(User(dictionary: dictionary!))
        }
    }
    
    static func fetchConversations(completion: @escaping([Conversation]) -> Void){
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timeStamp")
        
        query.addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: Faild to download recent messages with error \(error.localizedDescription)")
                return
            }
            snapshot?.documentChanges.forEach{ messages in
                let dictionaryMessage = messages.document.data()
                let message = Message(dictionary: dictionaryMessage)
               
                self.fetchUser(withUID: message.toID) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
                
            }
             
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let data = ["text": message,
                    "fromID": currentUid,
                    "toID": user.uid,
                    "timeStamp": Timestamp(date: Date())]
                                                        as [String: Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
            
            COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
            
            COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
        }
    }
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void){
        var messages = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
      let query =  COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timeStamp")
        query.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("DEBUG: Faild to download messages with error \(error.localizedDescription)")
                return
            }
            snapshot?.documentChanges.forEach { change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
                
            }
        })
       
    }
}
