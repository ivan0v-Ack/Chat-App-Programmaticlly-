//
//  LoginViewModel.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsVaild: Bool { get }
    
}
struct LoginViewModel: AuthenticationProtocol {
   
   var email: String?
    var password: String?

    
    var formIsVaild: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
