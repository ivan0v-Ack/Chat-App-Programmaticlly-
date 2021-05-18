//
//  LoginController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
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
    
    private lazy var logginBtn: CustomButton = {
        let button = CustomButton(btnText: "Log In")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    private let emailTextField = CustomTextField(placeHolderText: "Email", isSecure: false)
    private let passTextField = CustomTextField(placeHolderText: "Password", isSecure: true)
    
    private let dontHaveAccountButton: CustomAccountButton = {
        let btn = CustomAccountButton(firstString: "Don't have an account?", secondString: " Sign Up")
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleSignUp() {
        print("DEBUG: clickSignUp!")
    }
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }else {
            viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    // MARK: - Helpers
    func checkFormStatus() {
        logginBtn.isEnabled = viewModel.formIsVaild
        logginBtn.backgroundColor = viewModel.formIsVaild ? .red : #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
      
    }
    
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
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
    
}

extension UIViewController {
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}

