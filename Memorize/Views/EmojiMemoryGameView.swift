//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2020-10-14.
//  Copyright © 2020 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack() {
           
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(viewModel.getThemeColor)
            Spacer()
            HStack() {
                Button(action: {
                    self.viewModel.restart()
                }) {
                    Text("New Game")
                }.frame(maxWidth: .infinity)
            }
        }.padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(viewModel.theme.themeName)
        .navigationBarItems(trailing: Text("Score: \(viewModel.score)").font(.headline))
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
            
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack() {
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: Drawing Constants
    
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}
