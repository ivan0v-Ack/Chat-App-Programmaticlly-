//
//  ConversationViewModel.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/2/21.
//

import UIKit


struct ConversationViewModel {
    
    private let conversation: Conversation
    
    var profileImageURL: URL? {
        return URL(string: conversation.user.prfileImageUrl)
    }
    
    var timeStamp: String {
        
        let date = conversation.message.timeStamp.dateValue()
        let dateFormatter = DateFormatter()
       // dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.dateFormat = "hh:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
    
}
