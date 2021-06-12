//
//  ConversationsController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"
class ConversationController: UIViewController {
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var conversations = [Conversation]()
    
    private lazy var newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.setWidth(24)
        button.imageView?.setHeight(24)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(title: "Messages", prefersLagreTitles: true)
    }
    // MARK: - Selectors
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
       let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    @objc func showProfile() {
        let profileController = ProfileController(style: .insetGrouped)
        profileController.delegate = self
        let nav = UINavigationController(rootViewController: profileController)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    // MARK: - API
    
    private func fetchConversations() {
        Service.fetchConversations { conversations in
            self.conversations = conversations
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
            print("DEBUG: User is not logged in. Present login screen")
            
        }else {
            print(Auth.auth().currentUser?.uid)
        }
    }
    
    private func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        }
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        }catch {
            print("DEBUG: Error signing out..")
        }
    }
    // MARK: - Helpers
    
    func configureUI () {
        view.backgroundColor = .white
      
        
        configureTableView()
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: CGSize(width: 56, height: 56), padding: .init(top: 0, left: 0, bottom: 16, right: 16))
        newMessageButton.layer.cornerRadius = 56/2
        
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
    }
    
    func showChatController(forUser user: User) {
         let chat = ChatController(user: user)
        navigationController?.pushViewController(chat, animated: true)
    }
    
    
}
 
extension ConversationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
    }
    
    
}
// MARK: - NewMessageControllerDelegate
extension ConversationController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wontsToStartChatWith user: User) {
        print("DEBUG: User in conversation controller is \(user.username)")
        dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
        
    }
}
extension ConversationController: ProfileControllerDelegate {
    func handleLogout() {
        logout()
    }
    
    
}

