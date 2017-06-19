//
//  Card.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation

/// A single playing card.
struct Card {
    let rank: Rank
    let suit: Suit

    /// - Note: This is always a positive number regardless of whether
    ///         this or the other card has the higher rank.
    /// - Parameter other: The card to be compared to this Card.
    /// - Returns: The absolute difference in rank between two `Card`s.
    public func differenceInRank(to other: Card) -> Int {
        return abs(self.rank.rawValue - other.rank.rawValue)
    }


    /// - Note: Returns the absolute difference in rank between this and another `Card`.
    public func rankDifference(to other: Card) -> Int {
        return abs(self.rank.rawValue - other.rank.rawValue)
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        return rank.description + " of " + suit.description
    }
}

extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.rank == rhs.rank && lhs.suit == rhs.suit
    }
}
