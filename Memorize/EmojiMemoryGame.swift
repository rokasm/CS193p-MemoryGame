//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2020-10-16.
//  Copyright © 2020 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame(random: Bool = false) -> MemoryGame<String> {
    
    let themes: Array<MemoryGame<String>.Theme> = [
       MemoryGame<String>.Theme(themeName: "Halloween",
                   numberOfPairsOfCards: 6,
                   emojis: ["🎃","👻", "🕷", "🌙", "👽", "🧟‍♀️"],
                   themeColor: "Orange"),
       MemoryGame<String>.Theme(themeName: "Halloween",
                    numberOfPairsOfCards: 6,
                   emojis: ["🎃","👻", "🕷", "🌙", "👽", "🧟‍♀️"],
                     themeColor: "Orange"),
       MemoryGame<String>.Theme(themeName: "Sky",
                                numberOfPairsOfCards: 6,
                                emojis: ["🌞","🌍", "🌤", "🌙", "❄️", "🌈"],
                     themeColor: "Yellow"),
       MemoryGame<String>.Theme(themeName: "Balls",
                     emojis: ["⚽️","🏀", "🏈", "⚾️", "🥎", "🏐"],
                     themeColor: "Blue"),
       MemoryGame<String>.Theme(themeName: "Money",
                  numberOfPairsOfCards: 6,
                  emojis: ["💵","💴", "💶", "💷", "💰", "💳"],
                  themeColor: "Green"),
       MemoryGame<String>.Theme(themeName: "Flags",
                  numberOfPairsOfCards: 6,
                  emojis: ["🇦🇽","🇦🇱", "🇩🇿", "🇦🇸", "🏴‍☠️", "🏁"],
                  themeColor: "Gray")
    ]
    
    let theme: MemoryGame<String>.Theme = random ? themes.randomElement()! : themes[0]
    let numberOfPairsOfCards = theme.numberOfPairsOfCards ?? Int.random(in: 2..<themes.count - 1)
        print(theme)
    
    return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards , theme: theme) {pairIndex in theme.emojis[pairIndex]}
}
 
var cards: Array<MemoryGame<String>.Card> {
    model.cards
}

var theme: MemoryGame<String>.Theme {
       model.theme
   }
    
var score: Int {
    model.score
}

func choose(card: MemoryGame<String>.Card) {
    model.choose(card: card)
}

func restart() {
    model = EmojiMemoryGame.createMemoryGame(random: true)
    }

}
