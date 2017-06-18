//
//  Deck.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation


/// A deck of playing cards.
/// - Note: The deck may contain no cards and still behave appropriately (i.e. nils are avoided by design).
struct Deck {

    // MARK: - local constants and variables.

    public var cardCount: Int {
        return deck.count
    }

    private var deck = [Card]()

    // MARK: - Public functions.

    init(_ size: DeckSize) {
        switch size {
        case .full:
            for suit in Suit.allSuits.reversed() {
                for rank in Rank.allRanks.reversed() {
                    deck.append(Card(rank: rank, suit: suit))
                }
            }
            shuffle()
        case .empty:
            break
        }
    }

    /// - Returns: The top card on the deck (after first removing it from the deck).
    public mutating func removeTopCard() -> Card {
        return deck.removeFirst()
    }

    /// Adds the given card to the top of the deck
    ///
    /// - Parameter card: The card to be added.
    public mutating func addToTop(_ card: Card) {
        deck.append(card)
    }

    // MARK: - Private functions.

    /// Shuffles all the cards in the deck into a random order.
    ///
    private mutating func shuffle() {
        for index in 0..<52 {
            let card = deck.remove(at: index)
            let newIndex = Int(arc4random_uniform(51))
            deck.insert(card, at: newIndex)
        }
    }
}
