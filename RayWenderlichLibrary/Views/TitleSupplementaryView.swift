//
//  TitleSupplementaryView.swift
//  RayWenderlichLibrary
//
//  Created by Andrey Sergienko on 3/21/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

final class TitleSupplementaryView:  UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: TitleSupplementaryView.self)
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init is not implemented")
    }
    
    private func configureLabel() {
        addSubview(textLabel)
        textLabel.font = .preferredFont(forTextStyle: .title2)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}
