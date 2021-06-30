//
//  Theme.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2021-06-22.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import Foundation
import SwiftUI

struct Theme: Codable, Identifiable {
    let id: UUID
    var themeName: String
    var numberOfPairsOfCards: Int
    var emojis: Array<String>
    var themeColor: UIColor.RGB
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let theme = try? JSONDecoder().decode(Theme.self, from: json!) {
            self = theme
        } else {
            return nil
        }
    }
    
    init(themeName: String, numberOfPairsOfCards: Int, emojis: [String], themeColor: UIColor.RGB) {
        self.themeName = themeName
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.emojis = emojis
        self.themeColor = themeColor
        self.id = UUID()
    }
    
}



