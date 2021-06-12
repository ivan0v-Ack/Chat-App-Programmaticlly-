//
//  NewMessageController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/20/21.
//

import UIKit
private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: class {
    func controller(_ controller: NewMessageController, wontsToStartChatWith user: User)
}

class NewMessageController: UITableViewController {
    // MARK: - Properties
    private var usersArray = [User]()
    private var filteredUsers = [User]()
    
    weak var delegate: NewMessageControllerDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUsers()
        configureSearchController()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI () {
        configureNavigationBar(title: "New Message", prefersLagreTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelHandler))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
    private func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        definesPresentationContext = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .systemPurple
            textField.backgroundColor = .white
        }
    }
    
    // MARK: - Selectors
    
    @objc func cancelHandler() {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - API
    
    private func fetchUsers () {
        Service.fetchUsers { users in
       
            DispatchQueue.main.async {
                self.usersArray = users
                self.tableView.reloadData()
            }
        }
    }

}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : usersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = inSearchMode ? filteredUsers[indexPath.row] : usersArray[indexPath.row]
       return cell
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = inSearchMode ? filteredUsers[indexPath.row] : usersArray[indexPath.row]
        delegate?.controller(self, wontsToStartChatWith: user)
        
        
    }
}

extension NewMessageController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filteredUsers = usersArray.filter{ user -> Bool in
            return user.username.contains(searchText) || user.fullname.contains(searchText)
            
        }
        print("DEBUG: \(filteredUsers)")
        self.tableView.reloadData()
        
    }
}
