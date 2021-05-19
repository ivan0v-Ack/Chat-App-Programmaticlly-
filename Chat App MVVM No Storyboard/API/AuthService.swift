//
//  AuthService.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/19/21.
//

import Foundation
import Firebase
import UIKit

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullName:String
    let username: String
    let profileImage: UIImage
}


struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail: String, password: String, completion: (AuthDataResultCallback?)){
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: completion )
        }
    
    func createUser (credentials: RegistrationCredentials, completion: @escaping (Error?) -> (Void)) {
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
       // let fileName = NSUUID().uuidString
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
//                print("DEBUG: Failed to crate user with error \(error.localizedDescription)")
                completion(error)
                return
            }
           
            guard let uid = result?.user.uid else { return }
            
        
        let ref = Storage.storage().reference(withPath: "/profile_images/\(uid)")
        ref.putData(imageData, metadata: nil) { (mera, error) in
            if let error = error {
//                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                completion(error)
                return
            }
            ref.downloadURL { (url, error) in
                if let error = error {
                    completion(error)
                   // print("DEBUG: Failed to download URL! \(error.localizedDescription)")
                    return
                }
               guard let profileImageURL = url?.absoluteString else { return }
                
                let data = ["email": credentials.email,
                            "fullName": credentials.fullName,
                            "profileImageURl": profileImageURL,
                            "uid": uid,
                            "username": credentials.username
                ] as [String: Any]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                
                
            }
        }
    }
    }
    }
    
 

