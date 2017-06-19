//
//  Robert.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation

class Robert {

    // MARK: - Public constants and properties.

    public private(set) var stock: Deck = Deck(.empty)
    public private(set) var suite: Deck = Deck(.empty)
    public private(set) var waste: Deck = Deck(.empty)

    public var delegate: RobertDelegate?

    // MARK: - Public functions.

    init() {
        newGame()
    }

    public func newGame() {
        stock = Deck(.full)
        suite = Deck(.empty)
        waste = Deck(.empty)

        suite.addToTop(stock.removeTopCard())
        delegate?.didStartNewGame()
    }

    public func selectStock() {
        switch selectedDeck {
        case .stock:
            selectedDeck = .none
        case .waste:
            selectedDeck = .none
        case .none:
            selectedDeck = .stock
        }
    }

    public func selectSuite() {
        switch  selectedDeck {
        case .stock:
            moveCard(from: &stock, to: &suite)
        case .waste:
            moveCard(from: &waste, to: &suite)
        case .none:
            break
        }
    }

    public func selectWaste() {
        switch selectedDeck {
        case .stock:
            moveCard(from: &stock, to: &waste)
        case .waste:
            selectedDeck = .none
        case .none:
            selectedDeck = .waste
        }
    }

    // MARK: - Private constants and properties

    private var selectedDeck = RobertDeck.none {
        didSet {
            delegate?.didSelect(selectedDeck)
        }
    }

    // MARK: - Private functions.

    private func moveCard(from source: inout Deck, to destination: inout Deck) {
        selectedDeck = .none
        guard source.cardCount > 0 else {
            return
        }
        if destination === suite  &&
            source.topCard.rankDifference(to: destination.topCard) != 1 {
            return
        }
        destination.addToTop(source.removeTopCard())
    }
}
