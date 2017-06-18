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
}
