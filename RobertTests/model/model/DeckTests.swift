//
//  DeckTests.swift
//  RobertTests
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import XCTest
@testable import Robert

class DeckTests: XCTestCase {

    let fullDeck = Deck(.full)
    let emptyDeck = Deck(.empty)
    
    func testDeckSize() {
        XCTAssertEqual(52, fullDeck.cardCount)
        XCTAssertEqual( 0, emptyDeck.cardCount)
    }

    func testAddToBottom() {
        let cards12 = [Card(rank: .ace, suit: .clubs), Card(rank: .two, suit: .clubs)]
        let cards34 = [Card(rank: .three, suit: .clubs), Card(rank: .four, suit: .clubs)]
        let deck = Deck(cards: cards12)
        deck.addToBottom(cards: cards34)
        XCTAssertEqual(4, deck.cardCount)
        XCTAssertEqual(Card(rank: .ace, suit: .clubs), deck.removeTopCard())
        XCTAssertEqual(Card(rank: .two, suit: .clubs), deck.removeTopCard())
        XCTAssertEqual(2, deck.cardCount)
        XCTAssertEqual(Card(rank: .three, suit: .clubs), deck.topCard!)
    }
}
