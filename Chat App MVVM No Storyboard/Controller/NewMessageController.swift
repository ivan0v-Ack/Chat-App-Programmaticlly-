//
//  NewMessageController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/20/21.
//

import UIKit
private let reuseIdentifier = "UserCell"
class NewMessageController: UITableViewController {
    // MARK: - Properties
    private var usersArray = [User]()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUsers()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI () {
        configureNavigationBar(title: "New Message", prefersLagreTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelHandler))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
    // MARK: - Selectors
    
    @objc func cancelHandler() {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - API
    
    private func fetchUsers () {
        Service.fetchUsers { users in
          //  print("DEBUG: \(user.email)")
            DispatchQueue.main.async {
                self.usersArray = users
                self.tableView.reloadData()
            }
        }
    }

}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = usersArray[indexPath.row]
       return cell
    }
}
