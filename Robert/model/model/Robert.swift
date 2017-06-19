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

    public var stockEnabled: Bool { return stock.cardCount > 0 }
    public var suiteEnabled: Bool { return suite.cardCount > 0 }
    public var wasteEnabled: Bool { return waste.cardCount > 0 }

    public var delegate: RobertDelegate?

    public enum GameState {
        case firstDeal
        case firstDealPlayedOut
        case secondDeal
        case gameLost
        case gameWon
    }

    enum ActiveDeck {
        case none
        case stock
        case waste
    }

    // MARK: - Public functions.

    init() {
        newGame()
    }

    public func newGame() {
        gameState = .firstDeal

        stock = Deck(.full)
        suite = Deck(.empty)
        waste = Deck(.empty)

        suite.addToTop(stock.removeTopCard())
        delegate?.didStartNewGame()
    }

    public func selectStock() {
        if gameState == .firstDealPlayedOut {
            redeal()
            activeDeck = .none
        } else {
            switch activeDeck {
            case .stock:
                activeDeck = .none
            case .waste:
                activeDeck = .none
            case .none:
                activeDeck = .stock
            }
        }
    }

    public func selectSuite() {
        switch  activeDeck {
        case .stock:
            moveCard(from: &stock, to: &suite)
        case .waste:
            moveCard(from: &waste, to: &suite)
        case .none:
            break
        }
    }

    public func selectWaste() {
        switch activeDeck {
        case .stock:
            moveCard(from: &stock, to: &waste)
        case .waste:
            activeDeck = .none
        case .none:
            activeDeck = .waste
        }
    }

    // MARK: - Private constants and properties

    private var gameState = GameState.firstDeal {
        didSet {
            delegate?.didChangeState(to: gameState)
        }
    }

    private var activeDeck = ActiveDeck.none {
        didSet {
            delegate?.didSelect(activeDeck)
        }
    }

    // MARK: - Private functions.

    private func moveCard(from source: inout Deck, to destination: inout Deck) {
        activeDeck = .none
        guard source.cardCount > 0 else {
            return
        }
        if destination === suite  &&
            source.topCard.rankDifference(to: destination.topCard) != 1 {
            return
        }
        destination.addToTop(source.removeTopCard())
        updateGameState()
    }

    private func updateGameState() {
        if stock.containsCards { return }

        switch gameState {
        case .firstDeal:
            gameState = .firstDealPlayedOut
        case .secondDeal:
            if waste.isEmpty {
                gameState = .gameWon
            } else if !topWasteCardIsPlayable() {
                gameState = .gameLost
            }
        default:
            break
        }
    }

    private func topWasteCardIsPlayable() -> Bool {
        return waste.containsCards && waste.topCard.differenceInRank(to: suite.topCard) == 1
    }

    private func redeal() {
        guard gameState == .firstDealPlayedOut else {
            return
        }
        stock = waste
        waste = Deck(.empty)
        gameState = .secondDeal
    }
}

