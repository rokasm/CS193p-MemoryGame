//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2020-10-16.
//  Copyright © 2020 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    init(theme: Theme) {
        self.theme = theme
        model  = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
                
        return MemoryGame<String>(theme: theme) {pairIndex in theme.emojis[pairIndex]}
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var theme: Theme
    
    var getThemeColor: Color {
        Color(theme.themeColor)
    }
    
    var score: Int {
        model.score
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
}
