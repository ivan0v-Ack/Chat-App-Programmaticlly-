//
//  CustomInputAccessoryView.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/21/21.
//

import UIKit

protocol CustomInputAccessoryViewDelegate: class {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}

class CustomInputAccessoryView: UIView {
    // MARK: - Propetries
    
    weak var delegate: CustomInputAccessoryViewDelegate?
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    private lazy var messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
     private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, trailing: trailingAnchor,size: CGSize(width: 50, height: 50), padding: .init(top: 4, left: 0, bottom: 0, right: 8))
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: sendButton.leadingAnchor,  padding: .init(top: 12, left: 4, bottom: 8, right: 8))
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(leading: messageInputTextView.leadingAnchor, centerY: messageInputTextView.centerYAnchor, padding: .init(top: 0, left: 4, bottom: 0, right: 0))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleStartTyping), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Selectors
    
    @objc func handleSendMessage() {
        print("DEBUG: Handle send message here..!")
        guard let message = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSend: message)
        
    }
    
    @objc func handleStartTyping() {
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
    
    // MARK: - Helpers
    
    func clearMessageText() {
        messageInputTextView.text = ""
        placeholderLabel.isHidden = false
    }
}
