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
class Deck {

    // MARK: - local constants and variables.

    public var cardCount: Int {
        return deck.count
    }

    public var isEmpty: Bool {
        return deck.count == 0
    }

    public var containsCards: Bool {
        return !isEmpty
    }

    public private(set) var deck = [Card]()

    // MARK: - Public functions.

    init(_ size: DeckSize) {
        switch size {
        case .full:
            deck = fullDeck().shuffled()
        case .empty:
            break
        }
    }

    init (cards: [Card]) {
        deck = cards
    }

    private func fullDeck() -> [Card] {
        var cards = [Card]()
        // Suits and ranks are added in reverse order, so that final deck
        // runs from the ace of clubs through to the king of spades.
        for suit in Suit.allSuits.reversed() {
            for rank in Rank.allRanks.reversed() {
                cards.append(Card(rank: rank, suit: suit))
            }
        }
        return cards
    }

    /// - Returns: The top card on the deck (after first removing it from the deck).
    public func removeTopCard() -> Card {
        return deck.removeFirst()
    }

    /// Adds the given card to the top of the deck
    ///
    /// - Parameter card: The card to be added.
    public func addToTop(_ card: Card) {
        deck.insert(card, at: 0)
    }

    public var topCard: Card? {
        return deck.first
    }


    /// Adds the given set of cards to the bottom of this deck.
    /// So, if this deck contains top[1C, 2D, 3H]bottom and top[4S, 5C, 6H]bottom is
    /// added to the bottom then the result will be top[1C, 2D, 3H, 4S, 5C, 6H]bottom.
    ///
    /// - Parameter cards: The cards to be added.
    ///
    public func addToBottom(cards: [Card]) {
        deck.append(contentsOf: cards)
    }

    // MARK: - Private functions.
}


// Array<Card> extension.
extension Array where Iterator.Element == (Card) {
    /// Shuffles all the cards in the deck into a random order.
    ///
    func shuffled() -> [Card]{
        var newDeck = [Card]()
        // Copy each card in turn form this array to a random position in the new array.
        for oldIndex in 0..<52 {
            let newIndex = Int(arc4random_uniform(UInt32(newDeck.count)))
            newDeck.insert(self[oldIndex], at: newIndex)
        }
        return newDeck
    }
}

