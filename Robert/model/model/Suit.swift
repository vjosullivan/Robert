//
//  Suit.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation

/// The four suits in a traditional English deck of cards.
///
enum Suit: Int {
    case clubs
    case diamonds
    case hearts
    case spades

    /// A `Range` that spans all suits.
    private static let all = clubs.rawValue...spades.rawValue

    /// An iterable array of all suits.
    public static let allSuits = Array(all.map{ Suit(rawValue: $0)! })
}

extension Suit: CustomStringConvertible {
    var description: String {
        return ["Clubs", "Diamonds", "Hearts", "Spades"][self.rawValue]
    }
}
