//
//  ConversationCell.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/2/21.
//

import UIKit

class ConversationCell : UITableViewCell {
    
    // MARK: - Properties
    var conversation: Conversation? {
        didSet { configureUI() }
    }
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    lazy var timeStampLabel: DateHeaderLabel = {
        let label = DateHeaderLabel()
         return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.anchor(leading: leadingAnchor,centerY: centerYAnchor, size: CGSize(width: 50, height: 50), padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        profileImageView.layer.cornerRadius = 50 / 2
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel, messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(leading: profileImageView.trailingAnchor, trailing: trailingAnchor, centerY: profileImageView.centerYAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 16))
        
        addSubview(timeStampLabel)
        timeStampLabel.anchor(top: topAnchor, trailing: trailingAnchor,padding: .init(top: 20, left: 0, bottom: 0, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI () {
        guard let conversation = conversation else { return }
        let viewModel = ConversationViewModel(conversation: conversation)
        userNameLabel.text = conversation.user.fullname
        messageTextLabel.text = conversation.message.text
        
        timeStampLabel.text = viewModel.timeStamp
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
      
    }
}
