//
//  ProfileViewModel.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/11/21.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    case example
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Setings"
        case .example: return "Example"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        case .example: return "house"
        }
    }
}
