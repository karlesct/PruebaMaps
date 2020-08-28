//
//  UIColor+RandomTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 28/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class UIColor_RandomTest: XCTestCase {

    func testRandom_01() {
        XCTAssertNotNil(UIColor.random)
    }

}
