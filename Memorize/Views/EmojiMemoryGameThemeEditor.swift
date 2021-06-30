//
//  EmojiMemoryGameThemeEditor.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2021-06-22.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameThemeEditor: View {
    @Binding var themeID: UUID
    @EnvironmentObject var store: EmojiMemoryGameThemeStore
    @State private var themeName: String = ""
    @State private var emojisToAdd: String = ""
    @State private var emojis: [String] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section {
                TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                    if !began {
                        store.updateThemeName(themeID, to: themeName)
                    }
                })
                TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                    if !began {
                        store.addEmoji(themeID, emojis: emojisToAdd.map { String($0) })
                        emojis = emojis + emojisToAdd.map { String($0) }
                        self.emojisToAdd = ""
                    }
                })
            }
            Section {
                Grid(emojis, id: \.self) { item in
                    Text(item).onTapGesture {
                        store.removeEmoji(themeID, emoji: item)
                        emojis = emojis.filter { $0 != item }
                    }
                }
                .frame(height: self.height)
            }
            Section {
                Grid(colors, id: \.self) { item in
                    Rectangle().fill(Color(item)).onTapGesture {
                        store.setColor(themeID, color: item)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(themeName)
        .navigationBarItems(
            trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            })
        )
 
        .onAppear {
            if let theme = store.getTheme(themeID) {
                themeName = theme.themeName
                emojis = theme.emojis
            }
        }

    }

    var height: CGFloat {
        CGFloat((emojis.count - 1) / 6) * 70 + 70
    }
    let fontSize: CGFloat = 40
    
    var colors: [UIColor.RGB] = [
        UIColor.systemBlue.rgb,
        UIColor.systemGreen.rgb,
        UIColor.systemTeal.rgb,
        UIColor.systemRed.rgb,
        UIColor.systemGray2.rgb,
        UIColor.systemPink.rgb

    ]
}

