//
//  UserCell.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/20/21.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    // MARK: - Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Spiderman"
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Peter Parker"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure(){
        guard let user = user else { return }
        usernameLabel.text = user.username
        fullNameLabel.text = user.fullname
        
        guard let url = URL(string: user.prfileImageUrl) else {return}
        profileImageView.sd_setImage(with: url)
    }
    
  private func configureUI() {
        backgroundColor = .systemPink
        addSubview(profileImageView)
        profileImageView.anchor(leading: leadingAnchor, centerY: centerYAnchor, size: CGSize(width: 64, height: 64), padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        profileImageView.layer.cornerRadius = 64/2
    
    let stack = UIStackView(arrangedSubviews: [usernameLabel,fullNameLabel])
    stack.axis = .vertical
    stack.spacing = 2
    addSubview(stack)
    stack.anchor(leading: profileImageView.trailingAnchor, centerY: profileImageView.centerYAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
    }
}
