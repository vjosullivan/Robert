//
//  RobertTests.swift
//  RobertTests
//
//  Created by Vincent O'Sullivan on 18/06/2017.
//  Copyright © 2017 Rose Cottage Industry. All rights reserved.
//

import XCTest
@testable import Robert

class RobertTests: XCTestCase {

    let robert = Robert()

    func testInitialState() {
        XCTAssertEqual(51, robert.stock.cardCount)
        XCTAssertEqual( 1, robert.suite.cardCount)
        XCTAssertEqual( 0, robert.waste.cardCount)
    }
}
