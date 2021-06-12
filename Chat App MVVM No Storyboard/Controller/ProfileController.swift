//
//  ProfileController.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/3/21.
//

import UIKit
import Firebase

private let reuseIdentifier = "profileCell"

protocol ProfileControllerDelegate: class {
    func handleLogout()
}


class ProfileController: UITableViewController {
    // MARK: - Properties
    
    weak var delegate: ProfileControllerDelegate?
    
    var user: User? {
        didSet { profileheader.user = user }
    }
    
    private lazy var profileheader = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private let footerView = ProfileFooter()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tableView.tableHeaderView = profileheader
        profileheader.delegate = self
        
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureUI(){
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        
        footerView.delegate = self
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
        
        
    }
    
    
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUID: uid) { user in
            self.user = user
            
        }
    }
}
// MARK: - UITableView DataSource
extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
}
// MARK: - UITableView Delegate
extension ProfileController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else { return }
        switch viewModel {
        case .accountInfo: print("Info page")
        case .settings: print("Setings")
        case .example: print("example")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func dissmisProfile() {
        dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - ProfileFooterDelegate
extension ProfileController: ProfileFooterDelegate {
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to logout", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
       
    }
    
    
}
