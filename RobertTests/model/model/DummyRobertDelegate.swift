//
//  DummyRobertDelegate.swift
//  RobertTests
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation
@testable import Robert

class DummyRobertDelegate: RobertDelegate {
    func didMoveCards() {
        // TODO: 
    }

    public private(set) var activeDeck = Robert.ActiveDeck.none
    public private(set) var changeCount = 0
    public private(set) var gameCount = 0

    func didStartNewGame() {
        gameCount += 1
    }

    func didSelect(_ deck: Robert.ActiveDeck) {
        activeDeck = deck
        changeCount += 1
    }

    func didChangeState(to gameState: Robert.GameState) {
        // TODO:
    }
}
