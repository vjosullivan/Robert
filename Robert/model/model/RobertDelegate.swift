//
//  RobertDelegate.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation

protocol RobertDelegate {

    /// Called when a new game is started.
    ///
    func didStartNewGame()

    /// Called whenever the user selects a (new?) deck.
    ///
    /// - Parameter deck: The selected deck.
    ///
    func didSelect(_ deck: Robert.ActiveDeck)

    /// Called whenever the game state changes.
    ///
    /// - Parameter gameState: The new game state.
    ///
    func didChangeState(to gameState: Robert.GameState)
}
