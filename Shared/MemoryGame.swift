//
//  MemoryGame.swift
//  MemorizeSwiftUI
//
//  Created by Elex Lee on 1/26/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var faceUpCardIndex: Int? {
        get { cards.indices.filter( { cards[$0].isFaceUp } ).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched else { return }
        if let faceupIndex = faceUpCardIndex {
            if cards[faceupIndex].content == cards[chosenIndex].content {
                cards[faceupIndex].isMatched = true
                cards[chosenIndex].isMatched = true
            }
            cards[chosenIndex].isFaceUp = true
        } else {
            faceUpCardIndex = chosenIndex
        }
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
        cards = []
        
        // add numberOfPairsOfCards * 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
