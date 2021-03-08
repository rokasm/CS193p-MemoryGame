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
    
    func themeColor(string: String) -> Color {
            switch string {
               case "Orange":
                   return Color.orange
               case "Yellow":
                    return Color.yellow
               case "Blue":
                    return Color.blue
               case "Green":
                    return Color.green
               case "Grey":
                    return Color.gray
               default:
                    return Color.orange
              }
       }
    

    var body: some View {
        VStack() {
            HStack() {
                Button(action: {
                    self.viewModel.restart()
                }) {
                    Text("New Game")
                }.frame(maxWidth: .infinity)
                Text(viewModel.theme.themeName).font(.headline).frame(maxWidth: .infinity)
                Text("Score: \(self.viewModel.score)").font(.headline).frame(maxWidth: .infinity)
            }
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            .padding(5)
            }
                .padding()
            .foregroundColor(themeColor(string: viewModel.theme.themeColor))
            Spacer()
        }.padding()
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
            
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack() {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: Drawing Constants
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
