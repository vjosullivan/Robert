//
//  CardTests.swift
//  RobertTests
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import XCTest
@testable import Robert

class CardTests: XCTestCase {
    
    let card5D = Card(rank: Rank.five, suit: Suit.diamonds)
    let cardAS = Card(rank: Rank.ace, suit: Suit.spades)

    func testDescription() {
        XCTAssertEqual("Five of Diamonds", card5D.description)
    }

    func testRankDifference() {
        XCTAssertEqual(4, card5D.differenceInRank(to: cardAS))
        XCTAssertEqual(4, cardAS.differenceInRank(to: card5D))
    }

    func testEquality() {
        let testCard = Card(rank: Rank.ace, suit: Suit.spades)
        XCTAssertEqual(testCard, cardAS)
        XCTAssertNotEqual(testCard, card5D)
   }
}
