//
//  RegistrationController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//

import UIKit
import Firebase

protocol AuthenticationStatus {
    func checkForStatus()
    
}
class RegistrationController: UIViewController {
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    // MARK: - Properties
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.imageView?.clipsToBounds = true
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
        button.isEnabled = false
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
        
        guard let email = emailTextField.text,
              let password = passTextField.text,
              let fullname = fullNameTextField.text,
              let username = userNameTextField.text?.lowercased(),
              let profileImage = profileImage
        else { return }
        showLoader(true, withText: "Signing You Up!")
        let credentials = RegistrationCredentials(email: email, password: password, fullName: fullname, username: username, profileImage: profileImage)
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                self.showLoader(false)
                return
                
            }
            self.dismiss(animated: true, completion: nil)
            self.showLoader(false)
        }
        
       
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
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passTextField {
            viewModel.password = sender.text
        }else if sender == userNameTextField {
            viewModel.userName = sender.text
        }else {
            viewModel.fullName = sender.text
        }
        checkForStatus()
    }
    
    @objc func keyBoardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y = -88
        }
    }

    @objc func keyBoardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
        
        configureNotificationObsercers()
    }
    
    func configureNotificationObsercers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
     
}
// MARK: - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage]as? UIImage else {
                    fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                }
        profileImage = image
        plusPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.cornerRadius = (plusPhotoButton.frame.height) / 2
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        
      
        dismiss(animated: true, completion: nil)
    }
    
    
}


extension RegistrationController: AuthenticationStatus {
    func checkForStatus() {
        signUpBtn.isEnabled = viewModel.formIsVaild ? true : false
        signUpBtn.backgroundColor = viewModel.formIsVaild ? .red : #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
    }
    
    
}


