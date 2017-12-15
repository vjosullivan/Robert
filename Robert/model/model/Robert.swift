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
    public var wasteEnabled: Bool { return waste.cardCount > 0 }

    public var stockImageName: String {
        if let card = stock.topCard {
            return card.imageName
        } else {
            switch robertState {
            case .firstRoundCompleted, .secondRoundCompleted:
                return "zone_circle"
            default:
                return "zone_cross"
            }
        }
    }

    public var suiteImageName: String {
        // The suite always contains at least one card.
        return suite.topCard!.imageName
    }

    public var wasteImageName: String {
        return waste.topCard?.imageName ?? "zone"
    }

    public var stockPlayable: Bool {
        guard let card = stock.topCard else { return false }

        return card.differenceInRank(to: suite.topCard!) == 1
    }

    public var wastePlayable: Bool {
        guard let card = waste.topCard else { return false }

        return card.differenceInRank(to: suite.topCard!) == 1
    }

    public var delegate: RobertDelegate?

    public enum State {
        case firstRound
        case firstRoundCompleted
        case secondRound
        case secondRoundCompleted
        case finalRound
        case gameLost
        case gameWon
    }

    enum SelectedDeck {
        case none
        case stock
        case waste
    }

    // MARK: - Public functions.

    init() {
        newGame()
    }

    init(deck: Deck) {
        newGame(deck: deck)
    }

    public func newGame() {
        newGame(deck: Deck(.full))
    }

    public func selectStock() {
        switch robertState {
        case .firstRoundCompleted, .secondRoundCompleted:
            redeal()
            selectedDeck = .none
        case .gameWon, .gameLost:
            newGame()
        default:
            switch selectedDeck {
            case .stock:
                selectedDeck = .none
            case .waste:
                selectedDeck = .none
            case .none:
                selectedDeck = .stock
            }
        }
    }

    public func selectSuite() {
        switch selectedDeck {
        case .stock:
            moveCard(from: stock, to: suite)
        case .waste:
            moveCard(from: waste, to: suite)
        case .none:
            break
        }
    }

    public func selectWaste() {
        switch selectedDeck {
        case .stock:
            moveCard(from: stock, to: waste)
        case .waste:
            selectedDeck = .none
        case .none:
            selectedDeck = .waste
        }
    }

    // MARK: - Private constants and properties

    private var robertState = State.firstRound {
        didSet {
            delegate?.robert(self, didChangeState: robertState)
        }
    }

    private var selectedDeck = SelectedDeck.none {
        didSet {
            delegate?.robert(self, didSelectDeck: selectedDeck)
        }
    }

    // MARK: - Private functions.

    private func newGame(deck: Deck) {
        robertState = .firstRound

        stock = deck
        suite = Deck(.empty)
        waste = Deck(.empty)

        suite.addToTop(stock.removeTopCard())
        delegate?.robertDidStart(self)
        delegate?.robertDidMoveCards(self)
    }

    private func moveCard(from source: Deck, to destination: Deck) {
        selectedDeck = .none
        guard source.cardCount > 0 else {
            return
        }
        if destination === suite {
            // Both source and suite must/will contain cards hence "!" marks are OK.
            if source.topCard!.rankDifference(to: destination.topCard!) != 1 {
                return
            }
        }
        destination.addToTop(source.removeTopCard())
        updateGameState()
        delegate?.robertDidMoveCards(self)
        print(stock.cardCount, suite.cardCount, waste.cardCount)
    }

    private func updateGameState() {
        if stock.containsCards { return }

        switch robertState {
        case .firstRound:
            robertState = .firstRoundCompleted
        case .secondRound:
            robertState = .secondRoundCompleted
        case .finalRound:
            if waste.isEmpty {
                robertState = .gameWon
            } else if wastePlayable {
                return
            } else {
                robertState = .gameLost
            }
        default:
            break
        }
        delegate?.robert(self, didChangeState: robertState)
    }

    private func redeal() {
        guard robertState == .firstRoundCompleted ||
            robertState == .secondRoundCompleted else {
                return
        }
        // Invert the waste deck before moving it to the stock.
        stock.addToBottom(cards: waste.deck.reversed())
        waste = Deck(.empty)
        robertState = (robertState == .firstRoundCompleted) ? .secondRound : .finalRound
        delegate?.robert(self, didChangeState: robertState)
        delegate?.robertDidMoveCards(self)
    }
}

