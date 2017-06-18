//
//  Robert.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation

class Robert {

    // MARK: - Game state.

    public private(set) var stock: Deck = Deck(.empty)
    public private(set) var suite: Deck = Deck(.empty)
    public private(set) var waste: Deck = Deck(.empty)

    public var delegate: RobertDelegate?

    private var selectedDeck = RobertDeck.none {
        didSet {
            delegate?.didSelect(selectedDeck)
        }
    }

    // MARK: - Public functions.

    init() {
        newGame()
    }

    public func newGame() {
        stock = Deck(.full)
        suite = Deck(.empty)
        waste = Deck(.empty)

        moveStockToSuite()
        selectedDeck = .none
        delegate?.didStartNewGame()
    }

    public func selectStock() {
        switch selectedDeck {
        case .stock:
            selectedDeck = .none
        case .waste, .none:
            selectedDeck = .stock
        }
    }

    public func selectSuite() {
        switch  selectedDeck {
        case .stock:
            moveStockToSuite()
            selectedDeck = .none
        case .waste:
            moveWasteToSuite()
            selectedDeck = .none
        case .none:
            break
        }
    }

    public func selectWaste() {
        switch selectedDeck {
        case .stock:
            moveStockToWaste()
            selectedDeck = .none
        case .waste:
            selectedDeck = .none
        case .none:
            selectedDeck = .waste
        }
    }

    // MARK: - Private functions.

    private func moveStockToSuite() {
        guard stock.cardCount > 0 else {
            return
        }
        suite.addToTop(stock.removeTopCard())
    }

    private func moveStockToWaste() {
        guard stock.cardCount > 0 else {
            return
        }
        waste.addToTop(stock.removeTopCard())
    }

    private func moveWasteToSuite() {
        guard waste.cardCount > 0 else {
            return
        }
        suite.addToTop(waste.removeTopCard())
    }
}
