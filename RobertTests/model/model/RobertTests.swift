//
//  RobertTests.swift
//  RobertTests
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import XCTest
@testable import Robert

class RobertTests: XCTestCase {

    var robert: Robert?
    var dummyDelegate: DummyRobertDelegate?

    override func setUp() {
        robert = Robert()
        dummyDelegate = DummyRobertDelegate()
        robert?.delegate = dummyDelegate
    }

    func testInitialState() {
        XCTAssertEqual(51, robert?.stock.cardCount)
        XCTAssertEqual( 1, robert?.suite.cardCount)
        XCTAssertEqual( 0, robert?.waste.cardCount)
    }

    func testNewGameInformsDelegate() {
        XCTAssertEqual(0, dummyDelegate?.gameCount)
        robert?.newGame()
        XCTAssertEqual(1, dummyDelegate?.gameCount)
    }

    func testSelectStockInformsDelegate() {
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.ActiveDeck.stock, dummyDelegate?.activeDeck)
        // Selecting stock twice deselects it.
        robert?.selectStock()
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectStockAfterWasteSelectsNone() {
        robert?.selectWaste()
        XCTAssertEqual(Robert.ActiveDeck.waste, dummyDelegate?.activeDeck)
        robert?.selectStock()
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
    }

    func testSelectStockFromNoneMakeStockActive() {
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(Robert.ActiveDeck.stock, dummyDelegate?.activeDeck)
        XCTAssertEqual(1, dummyDelegate?.changeCount)
    }

    func testSelectSuiteFromNoneDoesNothing() {
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectSuite()
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
    }

    func testSelectSuiteAfterStockInformsDelegate() {
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.ActiveDeck.stock, dummyDelegate?.activeDeck)
        robert?.selectSuite()
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectSuiteAfterWasteInformsDelegate() {
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectWaste()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.ActiveDeck.waste, dummyDelegate?.activeDeck)
        robert?.selectSuite()
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectWasteInformsDelegate() {
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        robert?.selectWaste()
        XCTAssertEqual(Robert.ActiveDeck.waste, dummyDelegate?.activeDeck)
        // Selecting waste twice deselects it.
        robert?.selectWaste()
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
    }

    func testSelectWasteAfterStockInformsDelegate() {
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.ActiveDeck.stock, dummyDelegate?.activeDeck)
        robert?.selectWaste()
        XCTAssertEqual(Robert.ActiveDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }
}
