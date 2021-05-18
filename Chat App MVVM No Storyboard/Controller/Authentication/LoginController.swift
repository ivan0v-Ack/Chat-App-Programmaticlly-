//
//  LoginController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private lazy var iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    
    private lazy var emailContrainerView: InputContainerView = {
       return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField )
   }()
    
    private lazy var passwordContrainerView: InputContainerView = {
       return InputContainerView(image: UIImage(systemName: "lock"), textField: passTextField)
    }()
    
    private lazy var logginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemRed
        button.setHeight(50)
        return button
    }()
    private let emailTextField = CustomTextField(placeHolderText: "Email", isSecure: false)
    private let passTextField = CustomTextField(placeHolderText: "Password", isSecure: true)
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI () {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = .systemPurple
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: view.centerXAnchor, centerY: nil, size: CGSize(width: 120, height: 120), padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        let stack = UIStackView(arrangedSubviews: [emailContrainerView,
                                                   passwordContrainerView,
                                                   logginBtn])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerX: nil, centerY: nil,padding: .init(top: 32, left: 32, bottom: 0, right: 32))
    }
   
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}

