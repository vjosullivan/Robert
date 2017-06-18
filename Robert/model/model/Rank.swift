//
//  rank.swift
//  Robert
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import Foundation

/// Represents all the possible values of a playing card from "Ace" through to "King".
enum Rank: Int {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king

    /// A closed `Range` that spans all ranks.
    private static let all = ace.rawValue...king.rawValue

    /// An ordered, iterable array of all `Rank`s.
    public static let allRanks: [Rank] = {
        let allRawValues = Rank.ace.rawValue...Rank.king.rawValue
        return Array(allRawValues.map{ Rank(rawValue: $0)! })
    }()
}

extension Rank: CustomStringConvertible {
    var description: String {
        return [
            "Ace", "Two", "Three", "Four", "Five",
            "Six", "Seven", "Eight", "Nine", "Ten",
            "Jack", "Queen", "King"][self.rawValue - 1]
    }
}
