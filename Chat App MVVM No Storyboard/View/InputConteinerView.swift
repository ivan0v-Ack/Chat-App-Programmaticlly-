//
//  InputConteinerView.swift
//  Chat App MVVM No Storyboard
//
//  Created by Ivan Ivanov on 5/18/21.
//
import  UIKit

class InputContainerView: UIView {
  
    init(image: UIImage?, textField: UITextField) {
        super.init(frame: .zero)
        backgroundColor = .clear
    
        setHeight(50)

        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        iv.alpha = 0.87

        addSubview(iv)
        iv.anchor(leading: leadingAnchor, centerY: centerYAnchor, size: CGSize(width: 28, height: 24), padding: .init(top: 0, left: 8, bottom: 0, right: 0))

        addSubview(textField)
        textField.anchor(leading: iv.trailingAnchor,bottom: bottomAnchor,trailing: trailingAnchor ,centerY: centerYAnchor, padding: .init(top: 0, left: 8, bottom: -8, right: 0))
        
        let deviderView = UIView()
        deviderView.backgroundColor = .white
        addSubview(deviderView)
        deviderView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,size: CGSize(width: 0, height: 0.75), padding: .init(top: 0, left: 8, bottom: 0, right: 0))



    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
