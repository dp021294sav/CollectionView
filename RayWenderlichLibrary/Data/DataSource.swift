//
//  DataSource.swift
//  RayWenderlichLibrary
//
//  Created by Andrey Sergienko on 3/21/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class DataSource {
    var tutorials: [TutorialCollection]
    private let decoder = PropertyListDecoder()
    
    static let shared = DataSource()
    
    private init() {
        guard let url = Bundle.main.url(forResource: "Tutorials", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let tutorials = try? decoder.decode([TutorialCollection].self, from: data) else {
                self.tutorials = []
                return
        }
        
        self.tutorials = tutorials
    }
}
