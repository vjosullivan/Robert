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

    func robertDidMoveCards(_ robert: Robert) {
        // TODO: 
    }

    public private(set) var activeDeck = Robert.SelectedDeck.none
    public private(set) var changeCount = 0
    public private(set) var gameCount = 0

    func robertDidStart(_ robert: Robert) {
        gameCount += 1
    }

    func robert(_ robert: Robert, didSelectDeck deck: Robert.SelectedDeck) {
        activeDeck = deck
        changeCount += 1
    }

    func robert(_ robert: Robert, didChangeState state: Robert.State) {
        // TODO:
    }
}
