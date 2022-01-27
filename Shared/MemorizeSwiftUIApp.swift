//
//  MemorizeSwiftUIApp.swift
//  Shared
//
//  Created by Elex Lee on 1/26/22.
//

import SwiftUI

@main
struct MemorizeSwiftUIApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
