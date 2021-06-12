//
//  ProfileHeader.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/3/21.
//

import UIKit

protocol ProfileHeaderDelegate: class{
    func dissmisProfile()
}

class ProfileHeader: UIView {
    // MARK: - Properties
    
    var user: User? {
        didSet { populateData() }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private lazy var dismissButton: UIButton = {
        let image = UIImage(systemName: "xmark")
        let img = UIImageView(image: image)
        img.image = image?.sd_resizedImage(with: CGSize(width: 22, height: 22), scaleMode: .aspectFill)
        let button = UIButton(type: .system)
        //.withRenderingMode(.alwaysOriginal)
        button.setImage(img.image!, for: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4.0
        return iv
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        // label.text = "Ivan Ivanov"
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        //label.text = "@ivan0v "
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientLayer()
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func populateData() {
        guard let user = user, let url = URL(string:  user.prfileImageUrl ) else { return }
        userNameLabel.text = "@\(user.username)"
        fullNameLabel.text = user.fullname
        profileImageView.sd_setImage(with: url )
    }
    
    private func configureUI () {
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, centerX: centerXAnchor, size: CGSize(width: 200, height: 200), padding: .init(top: 96, left: 0, bottom: 0, right: 0))
        profileImageView.layer.cornerRadius = 200 / 2
        
        let stack = UIStackView(arrangedSubviews: [fullNameLabel, userNameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, leading: leadingAnchor, size: .init(width: 50, height: 50), padding: .init(top: 44, left: 12, bottom: 0, right: 0))
        
    }
    
    private func configureGradientLayer() {
        backgroundColor = .clear
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        layer.addSublayer(gradient)
        gradient.frame = bounds
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        
        delegate?.dissmisProfile()
    }
    
}
