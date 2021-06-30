//
//  EmojiMemomryGameThemeChooser.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2021-06-22.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameThemeChooser: View {
    
    @EnvironmentObject var store: EmojiMemoryGameThemeStore
    @State private var editMode: EditMode = .inactive
    @State private var editSheetVisible = false
    @State var selectedTheme: UUID = UUID()
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: destination(theme) ) {
                        HStack {
                            VStack(alignment: .leading){
                                Text(theme.themeName)
                                HStack {
                                    ForEach(theme.emojis, id: \.self) { item in
                                        Text(item)
                                    }
                                }
                                
                            }
                        }
                    }
                    .listRowBackground(Color(theme.themeColor))
                    .onTapGesture {
                        if editMode.isEditing {
                            selectedTheme = theme.id
                            editSheetVisible = true
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { self.store.themes[$0] }.forEach { theme in
                        self.store.removeTheme(theme: theme)
                    }
                }
                
            }
            .navigationBarTitle("Themes")
            .navigationBarItems(
                leading: Button(action: {
                    self.store.addTheme()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $editSheetVisible) {
                NavigationView {
                    EmojiMemoryGameThemeEditor(themeID: $selectedTheme).environmentObject(store)
                }
            }
        }
    }
    
    @ViewBuilder
    func destination(_ theme: Theme) -> some View {
        if !editMode.isEditing  {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
        }
    }
    
    @ViewBuilder
    func editButton(_ theme: UUID) -> some View {
        if editMode.isEditing {
            Button(action: {
                selectedTheme = theme
                editSheetVisible = true
            }) {
                Image(systemName: "slider.horizontal.3")
            }.buttonStyle(PlainButtonStyle()).padding(.leading)
        }
        
    }
    
}

