//
//  CustomTimeStamp.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 6/2/21.
//

import UIKit


class DateHeaderLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        textColor = .white
        textAlignment = .center
        font = UIFont.boldSystemFont(ofSize: 14)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalContentSize.width + 16, height: height )
    }
}
