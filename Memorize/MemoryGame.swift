//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2020-10-16.
//  Copyright © 2020 Rokas Mikelionis. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
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
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = IndexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
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
                IndexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            self.cards[chosenIndex].isFaceUp = true
        }
    
    }
    
    
    init(theme: Theme, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        self.score = 0
        
        for pairIndex in 0..<theme.numberOfPairsOfCards {
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
 

}
