//
//  ProfileFooter.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/11/21.
//

import UIKit

protocol ProfileFooterDelegate: class {
    func handleLogout()
}

class ProfileFooter: UIView {
    // MARK: - Properties
    
    weak var delegate: ProfileFooterDelegate?
    
    private lazy var logautButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logaut", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(logoutProfile), for: .touchUpInside)
        return button
        
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logautButton)
        logautButton.anchor(leading: leadingAnchor, trailing: trailingAnchor, centerY: centerYAnchor, size: CGSize(width: 0, height: 50), padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    
    // MARK: - Selectors
    
    @objc func logoutProfile() {
        delegate?.handleLogout()
    }
}
