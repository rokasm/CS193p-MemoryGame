//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2020-10-16.
//  Copyright © 2020 Rokas Mikelionis. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var theme: Theme
    var score: Int

    var IndexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter{ cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            print(1)
            if let potentialMatchIndex = IndexOfTheOneAndOnlyFaceUpCard {
                print(2)
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    print(3)
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score = score + 2
                } else {
                    if (cards[chosenIndex].seen) {
                        score = score - 1
                    }
                    if (cards[potentialMatchIndex].seen) {
                        score = score - 1
                  }
                }
                cards[chosenIndex].seen = true
                cards[potentialMatchIndex].seen = true
            } else {
                print(4)
                IndexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            print(5)
            self.cards[chosenIndex].isFaceUp = true
        }
    
    }
    
    
    init(numberOfPairsOfCards: Int, theme: Theme, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        self.theme = theme
        self.score = 0
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var seen: Bool = false
        var content: CardContent
        var id: Int
    }
    
    struct Theme {
        var themeName: String
        var numberOfPairsOfCards: Int?
        var emojis: Array<String>
        var themeColor: String
    }
}
