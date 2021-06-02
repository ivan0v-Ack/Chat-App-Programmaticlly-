//
//  MessageViewModel.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/1/21.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? #colorLiteral(red: 0.8005259037, green: 0.7957683206, blue: 0.8041839004, alpha: 1) : .systemPurple
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    var trailingAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leadingAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHudeProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageURL: URL? {
        guard let user = message.user else { return nil }
        return URL(string: user.prfileImageUrl)! 
    }
    
    
    
    init(message: Message) {
        self.message = message
    }
    
    
}
