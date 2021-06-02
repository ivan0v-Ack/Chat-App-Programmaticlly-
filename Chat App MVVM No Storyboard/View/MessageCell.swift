//
//  MessageCell.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/31/21.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Propetries
    
    var message: Message? {
        didSet { configureUI() }
    }
   // override var leadingAnchor: NSLayoutXAxisAnchor
    //override var trailingAnchor: NSLayoutXAxisAnchor
    var bubbleLeadingAnchor: NSLayoutConstraint!
    var bubbleTrailingAnchor: NSLayoutConstraint!
    
    var profileImageLeadingAnchor: NSLayoutConstraint!
    var profileImageTrailingAnchor: NSLayoutConstraint!
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
       // tv.textColor = .white
        tv.text = "Some test message for now.."
        return tv
    }()
    
    private lazy var bubbleContainer: UIView = {
        let view = UIView()
      //view.backgroundColor = .systemPurple
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(profileImageView)
        profileImageView.anchor(size: CGSize(width: 32, height: 32))
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        profileImageLeadingAnchor = profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        profileImageTrailingAnchor = profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleLeadingAnchor = bubbleContainer.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12)
        bubbleTrailingAnchor = bubbleContainer.trailingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: -12)

        
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubbleContainer.addSubview(textView)
        
        textView.anchor(top: bubbleContainer.topAnchor, leading: bubbleContainer.leadingAnchor, bottom: bubbleContainer.bottomAnchor, trailing: bubbleContainer.trailingAnchor, padding: .init(top: 4, left: 12, bottom: 4, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI () {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)
        print(viewModel.messageBackgroundColor)
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        bubbleLeadingAnchor.isActive = viewModel.leadingAnchorActive
        bubbleTrailingAnchor.isActive = viewModel.trailingAnchorActive
        profileImageLeadingAnchor.isActive = viewModel.leadingAnchorActive
        profileImageTrailingAnchor.isActive = viewModel.trailingAnchorActive
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
    }
}
