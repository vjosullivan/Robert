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

    public private(set) var selectedDeck = RobertDeck.none
    public private(set) var changeCount = 0
    public private(set) var gameCount = 0

    func didStartNewGame() {
        gameCount += 1
    }

    func didSelect(_ deck: RobertDeck) {
        selectedDeck = deck
        changeCount += 1
    }
}