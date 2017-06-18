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
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(RobertDeck.stock, dummyDelegate?.selectedDeck)
        // Selecting stock twice deselects it.
        robert?.selectStock()
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectSuiteFromNoneDoesNothing() {
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectSuite()
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
    }

    func testSelectSuiteAfterStockInformsDelegate() {
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(RobertDeck.stock, dummyDelegate?.selectedDeck)
        robert?.selectSuite()
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectSuiteAfterWasteInformsDelegate() {
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectWaste()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(RobertDeck.waste, dummyDelegate?.selectedDeck)
        robert?.selectSuite()
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectWasteInformsDelegate() {
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
        robert?.selectWaste()
        XCTAssertEqual(RobertDeck.waste, dummyDelegate?.selectedDeck)
        // Selecting waste twice deselects it.
        robert?.selectWaste()
        XCTAssertEqual(RobertDeck.none, dummyDelegate?.selectedDeck)
    }
}
