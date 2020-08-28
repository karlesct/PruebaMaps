//
//  Array+DistinctTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 28/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class Array_DistinctTest: XCTestCase {

    var okResultInt: [Int]!

    override func setUp() {
        super.setUp()

        okResultInt = [ 6, 3]

    }

    func testDistinct_01() {

        let test01 = [ 6, 3, 6, 3, 6]
        let test02 = [ 6, 3, 6, 3, 6, 6, 6, 3, 3]

        XCTAssertEqual(test01.distinct(), okResultInt)
        XCTAssertEqual(test02.distinct(), okResultInt)
    }

}
