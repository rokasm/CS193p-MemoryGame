//
//  EmojiMemoryGameThemeStore.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2021-06-21.
//  Copyright Β© 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI
import Combine

class EmojiMemoryGameThemeStore: ObservableObject {
    
    @Published var themesToSave = [Theme]()
    private var autosaveCancellabe: AnyCancellable?
    
    var themes: [Theme] {
        themesToSave
    }
    
    init() {
            themesToSave = [
                    Theme(themeName: "Halloween",
                          numberOfPairsOfCards: 5,
                          emojis: ["π","π»", "π·", "π", "π½", "π§ββοΈ"],
                          themeColor: UIColor.systemOrange.rgb),
                    Theme(themeName: "Sky",
                          numberOfPairsOfCards: 5,
                          emojis: ["π","π", "π€", "π", "βοΈ", "π"],
                          themeColor: UIColor.systemRed.rgb),
                    Theme(themeName: "Balls",
                          numberOfPairsOfCards: 6,
                          emojis: ["β½οΈ","π", "π", "βΎοΈ", "π₯", "π"],
                          themeColor: UIColor.systemGray.rgb),
                    Theme(themeName: "Money",
                          numberOfPairsOfCards: 5,
                          emojis: ["π΅","π΄", "πΆ", "π·", "π°", "π³"],
                          themeColor: UIColor.systemTeal.rgb),
                    Theme(themeName: "Flags",
                          numberOfPairsOfCards: 6,
                          emojis: ["π¦π½","π¦π±", "π©πΏ", "π¦πΈ", "π΄ββ οΈ", "π"],
                          themeColor: UIColor.systemGreen.rgb)
                ]
        
        autosaveCancellabe = $themesToSave.sink { themesToSave in
            UserDefaults.standard.set(themesToSave.map{ $0.json?.utf8 ?? "" }, forKey: "EmojiMemoryThemes")
        }
    }
    
    func removeTheme(theme: Theme) {
        if let index = themesToSave.firstIndex(matching: theme) {
            themesToSave.remove(at: index)
        }
    }
    
    func addTheme() {
        themesToSave.append(
            Theme(themeName: "New Theme",
                numberOfPairsOfCards: 1,
                emojis: ["π£ββοΈ"],
                themeColor: UIColor.systemOrange.rgb)
        )
    }
    
    func updateThemeName(_ themeID: UUID, to: String) {
        if let selectedIndex = themes.firstIndex(matching: getTheme(themeID)!) {
            themesToSave[selectedIndex].themeName = to
        }
    }
    
    func addEmoji(_ themeID: UUID, emojis: [String]) {
        if let selectedIndex = themes.firstIndex(matching: getTheme(themeID)!) {
            themesToSave[selectedIndex].emojis = themesToSave[selectedIndex].emojis + emojis
        }
    }
    
    func removeEmoji(_ themeID: UUID, emoji: String) {
        if let selectedIndex = themes.firstIndex(matching: getTheme(themeID)!) {
            themesToSave[selectedIndex].emojis = themesToSave[selectedIndex].emojis.filter { $0 != emoji }
        }
    }
    
    func setColor(_ themeID: UUID, color: UIColor.RGB) {
        if let selectedIndex = themes.firstIndex(matching: getTheme(themeID)!) {
            themesToSave[selectedIndex].themeColor = color
        }
    }
    
    func getTheme(_ themeID: UUID) -> Theme? {
        themes.first(where: { $0.id == themeID })
    }
    
}
