//
//  RegistrationController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
   
    
    private lazy var emailContrainerView: InputContainerView = {
       return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField )
   }()
    private lazy var fullNameContrainerView: InputContainerView = {
       return InputContainerView(image: UIImage(systemName: "envelope"), textField: fullNameTextField )
   }()
    private lazy var userNameContrainerView: InputContainerView = {
       return InputContainerView(image: UIImage(systemName: "envelope"), textField: userNameTextField )
   }()
    
    private lazy var passwordContrainerView: InputContainerView = {
       return InputContainerView(image: UIImage(systemName: "lock"), textField: passTextField)
    }()
    private let emailTextField = CustomTextField(placeHolderText: "Email", isSecure: false)
    private let fullNameTextField = CustomTextField(placeHolderText: "Full Name", isSecure: false)
    private let userNameTextField = CustomTextField(placeHolderText: "Username", isSecure: false)
    private let passTextField = CustomTextField(placeHolderText: "Password", isSecure: true)
    
    private lazy var signUpBtn: CustomButton = {
        let button = CustomButton(btnText: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let AlreadyaccountButton: CustomAccountButton = {
        let btn = CustomAccountButton(firstString: "Already have an account?", secondString: " Log In")
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureUI()
    }
    // MARK: - Selectors
    @objc func handleSignUp() {
        print("click signup")
    }
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleShowSignUp(){
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Helpers
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: view.centerXAnchor, centerY: nil, size: CGSize(width: 150, height: 150), padding: .init(top: 32, left: 0, bottom: 0, right: 0))

        
        let stackView = UIStackView(arrangedSubviews: [emailContrainerView,fullNameContrainerView,userNameContrainerView, passwordContrainerView,signUpBtn])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.anchor(top: plusPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerX: nil, centerY: nil,padding: .init(top: 32, left: 32, bottom: 0, right: 32))
        view.addSubview(AlreadyaccountButton)
        AlreadyaccountButton.anchor(leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        
        
    }
     
}
// MARK: - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage]as? UIImage else {
                    fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                }
        plusPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.cornerRadius = (plusPhotoButton.frame.height) / 2
        plusPhotoButton.imageView?.contentMode = .scaleToFill
        plusPhotoButton.imageView?.layer.cornerRadius = (plusPhotoButton.frame.height) / 2
        plusPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.imageView?.layer.masksToBounds = true
      
        dismiss(animated: true, completion: nil)
    }
    
    
}



