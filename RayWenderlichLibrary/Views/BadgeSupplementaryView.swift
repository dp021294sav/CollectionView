//
//  BadgeSupplementaryView.swift
//  RayWenderlichLibrary
//
//  Created by Andrey Sergienko on 3/22/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

final class BadgeSupplementaryView: UICollectionReusableView {
    static let reuseIdentifier = String(describing: BadgeSupplementaryView.self)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureView() {
        backgroundColor = UIColor(named: "rw-green")
        let radius = bounds.width / 2.0
        layer.cornerRadius = radius
    }
}
