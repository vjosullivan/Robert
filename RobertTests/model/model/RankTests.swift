//
//  RankTests.swift
//  RobertTests
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import XCTest
@testable import Robert

class RankTests: XCTestCase {

    func testRankDescription() {
        XCTAssertEqual("Ace", Rank.ace.description)
        XCTAssertEqual("Ten", Rank.ten.description)
    }

    func testRankOrder() {
        XCTAssertEqual(Rank.seven, Rank.allRanks[6])
        XCTAssertEqual(5, Rank.five.rawValue)
    }
}
