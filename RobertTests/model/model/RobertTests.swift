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
        XCTAssertEqual(51, robert!.stock.cardCount)
        XCTAssertEqual( 1, robert!.suite.cardCount)
        XCTAssertEqual( 0, robert!.waste.cardCount)
    }

    func testEnabledDecks() {
        // Initially, stock contains cards, waste does not.
        XCTAssertTrue(robert!.stockEnabled)
        XCTAssertFalse(robert!.wasteEnabled)

        // Move a card from the stock to the waste.
        robert!.selectStock()
        robert!.selectWaste()
        XCTAssertTrue(robert!.wasteEnabled)
    }

    func testStockWithCardImageName() {
        // Create a game with two cards.
        // The cards will go on the stock.
        // The top stock card is moved to the suite to start the game.
        // Leaving the second card, from the deck, on the stock
        let aceSpades = Card(rank: .ace, suit: .spades)
        let twoSpades = Card(rank: .two, suit: .spades)
        let game = Robert(deck: Deck(cards: [aceSpades, twoSpades]))

        XCTAssertEqual("two_of_spades", game.stockImageName)
    }

    func testStockEmptyImageName() {
        // Create a game with two cards.
        // The cards will go on the stock.
        // The top stock card is moved to the suite to start the game.
        // Leaving the second card, from the deck, on the stock
        let aceSpades = Card(rank: .ace, suit: .spades)
        let twoSpades = Card(rank: .two, suit: .spades)
        let game = Robert(deck: Deck(cards: [aceSpades, twoSpades]))
        // Move a card (the only card in the stock) from the stock to the waste.
        game.selectStock()
        game.selectWaste()

        // Expect a cross because cannot normally
        XCTAssertEqual("zone_circle", game.stockImageName)
    }

    func testStockGameOverImageName() {
        // Create a game with two cards.
        // The cards will go on the stock.
        // The top stock card is moved to the suite to start the game.
        // Leaving the second card, from the deck, on the stock
        let aceSpades = Card(rank: .ace, suit: .spades)
        let twoSpades = Card(rank: .two, suit: .spades)
        let game = Robert(deck: Deck(cards: [aceSpades, twoSpades]))
        // Stock contains one card.
        game.selectStock()
        game.selectWaste() // Stock moved to waste.  (End of first round.)
        game.selectStock() // Replenish stock from waste.
        game.selectStock()
        game.selectWaste() // Stock moved to waste.  (End of second round.)
        game.selectStock()
        game.selectStock() // Replenish stock from waste.
        game.selectWaste() // Stock moved to waste.  (End of third and final round.)

        XCTAssertEqual("zone_cross", game.stockImageName)
    }

    func testSuiteImageName() {
        let aceSpades = Card(rank: .ace, suit: .spades)
        let twoSpades = Card(rank: .two, suit: .spades)
        let game = Robert(deck: Deck(cards: [aceSpades, twoSpades]))

        XCTAssertEqual("ace_of_spades", game.suiteImageName)
    }

    func testWasteImageName() {
        // Create a game with two cards.
        // Play the stock to the waste.
        let aceSpades = Card(rank: .ace, suit: .spades)
        let twoSpades = Card(rank: .two, suit: .spades)
        let game = Robert(deck: Deck(cards: [aceSpades, twoSpades]))
        // Stock contains one card.
        XCTAssertEqual("two_of_spades", game.stockImageName)
        XCTAssertEqual("zone", game.wasteImageName)

        // Move stock card to waste.
        game.selectStock()
        game.selectWaste()

        XCTAssertEqual("zone_circle", game.stockImageName)
        XCTAssertEqual("two_of_spades", game.wasteImageName)
    }

    func testNewGameInformsDelegate() {
        XCTAssertEqual(0, dummyDelegate?.gameCount)
        robert?.newGame()
        XCTAssertEqual(1, dummyDelegate?.gameCount)
    }

    func testSelectStockInformsDelegate() {
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.SelectedDeck.stock, dummyDelegate?.activeDeck)
        // Selecting stock twice deselects it.
        robert?.selectStock()
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectStockAfterWasteSelectsNone() {
        robert?.selectWaste()
        XCTAssertEqual(Robert.SelectedDeck.waste, dummyDelegate?.activeDeck)
        robert?.selectStock()
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
    }

    func testSelectStockFromNoneMakeStockActive() {
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(Robert.SelectedDeck.stock, dummyDelegate?.activeDeck)
        XCTAssertEqual(1, dummyDelegate?.changeCount)
    }

    func testSelectSuiteFromNoneDoesNothing() {
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectSuite()
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
    }

    func testSelectSuiteAfterStockInformsDelegate() {
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.SelectedDeck.stock, dummyDelegate?.activeDeck)
        robert?.selectSuite()
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectSuiteAfterWasteInformsDelegate() {
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectWaste()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.SelectedDeck.waste, dummyDelegate?.activeDeck)
        robert?.selectSuite()
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }

    func testSelectWasteInformsDelegate() {
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        robert?.selectWaste()
        XCTAssertEqual(Robert.SelectedDeck.waste, dummyDelegate?.activeDeck)
        // Selecting waste twice deselects it.
        robert?.selectWaste()
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
    }

    func testSelectWasteAfterStockInformsDelegate() {
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(0, dummyDelegate?.changeCount)
        robert?.selectStock()
        XCTAssertEqual(1, dummyDelegate?.changeCount)
        XCTAssertEqual(Robert.SelectedDeck.stock, dummyDelegate?.activeDeck)
        robert?.selectWaste()
        XCTAssertEqual(Robert.SelectedDeck.none, dummyDelegate?.activeDeck)
        XCTAssertEqual(2, dummyDelegate?.changeCount)
    }
}
