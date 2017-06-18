//
//  SuitTests.swift
//  RobertTests
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import XCTest
@testable import Robert

class SuitTests: XCTestCase {

    func testSuitDescription() {
        XCTAssertEqual("Clubs", Suit.clubs.description)
        XCTAssertEqual("Hearts", Suit.hearts.description)
    }

    func testSuitOrder() {
        XCTAssertEqual(Suit.hearts, Suit(rawValue: Suit.diamonds.rawValue + 1))
    }
}
