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
    func robertDidStart(_ robert: Robert)

    /// Called whenever the user selects a (new?) deck.
    ///
    /// - Parameter deck: The selected deck.
    ///
    func robert(_ robert: Robert, didSelectDeck deck: Robert.SelectedDeck)

    /// Called whenever the game state changes.
    ///
    /// - Parameter gameState: The new game state.
    ///
    func robert(_ robert: Robert, didChangeState state: Robert.State)

    /// Called whenever the game moves cards.
    ///
    func robertDidMoveCards(_ robert: Robert)
}
