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

    // MARK: - Public functions.

    init() {
        newGame()
    }

    public func newGame() {
        stock = Deck(.full)
        suite = Deck(.empty)
        waste = Deck(.empty)

        suite.addToTop(stock.removeTopCard())
    }

    // MARK: - Private functions.
}
