//
//  CustomTextField.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeHolderText: String, isSecure: Bool) {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [.foregroundColor : UIColor.white])
        isSecureTextEntry = isSecure
        textColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
