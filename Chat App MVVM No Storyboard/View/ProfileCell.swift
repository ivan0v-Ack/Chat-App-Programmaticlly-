//
//  ProfileCell.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/11/21.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - Properties
    var stack: UIStackView!
    
    
    var viewModel: ProfileViewModel? {
        didSet { populateData() }
    }
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.addSubview(iconImage)
       iconImage.anchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        view.backgroundColor = .systemPurple
        view.anchor(size: CGSize(width: 40, height: 40))
        view.layer.cornerRadius = 40 / 2
        return view
    }()
  
    
    private lazy var iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.anchor(size: CGSize(width: 28, height: 28))
        iv.tintColor = .white
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "TEST!"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
        
        stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        addSubview(stack)
        stack.anchor(leading: leadingAnchor,centerY: centerYAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        stack.axis = .horizontal
        stack.spacing = 8
      
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Helpers
    
    private func populateData() {
       guard let viewModel = viewModel else { return }
        iconImage.image = UIImage(systemName: viewModel.iconImageName)
        titleLabel.text = viewModel.description

    }
}
