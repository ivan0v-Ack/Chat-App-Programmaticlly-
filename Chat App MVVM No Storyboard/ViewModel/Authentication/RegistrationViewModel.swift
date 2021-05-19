//
//  RegistrationViewModel.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/19/21.
//

import Foundation



struct RegistrationViewModel: AuthenticationProtocol {
  
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
    
    var formIsVaild: Bool {
        return email?.isEmpty == false && password?.isEmpty == false &&  userName?.isEmpty == false &&  fullName?.isEmpty == false
    }
    
    
}


