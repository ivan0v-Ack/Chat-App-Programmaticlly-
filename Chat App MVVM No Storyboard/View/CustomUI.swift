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

class CustomButton: UIButton {
    init(btnText: String){
        super.init(frame: .zero)
        setTitle(btnText, for: .normal)
        layer.cornerRadius = 5
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        setTitleColor(.white, for: .normal)
        isEnabled = false
        setHeight(50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomAccountButton: UIButton {
    init(firstString: String, secondString: String){
        super.init(frame: .zero)
    
    let attributedtTitle = NSMutableAttributedString(string: firstString, attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
    attributedtTitle.append(NSAttributedString(string: secondString, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
    setAttributedTitle(attributedtTitle, for: .normal)
   
}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    
    
