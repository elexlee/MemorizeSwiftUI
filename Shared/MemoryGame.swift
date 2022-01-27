//
//  MemoryGame.swift
//  MemorizeSwiftUI
//
//  Created by Elex Lee on 1/26/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var faceUpCardIndex: Int?
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched else { return }
        if let faceupIndex = faceUpCardIndex {
            if cards[faceupIndex].content == cards[chosenIndex].content {
                cards[faceupIndex].isMatched = true
                cards[chosenIndex].isMatched = true
            }
            faceUpCardIndex = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
//                if !cards[index].isMatched {
//                    cards[index].isFaceUp = false
//                }
            }
            faceUpCardIndex = chosenIndex
        }
        cards[chosenIndex].isFaceUp.toggle()
        print("chosenCard = \(cards[chosenIndex].content)")
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        // add numberOfPairsOfCards * 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
