//
//  String+LocalizedTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class String_LocalizedTest: XCTestCase {

    func testLocalized_01() {

        XCTAssertEqual("missing_key".localized, "**missing_key**")
    }

    func testLocalized_02() {

        XCTAssertEqual("app_missing_key".localized, "**app_missing_key**")
    }

    func testLocalized_03() {

        XCTAssertEqual("FirstTest".localized, "Test")
    }

    func testLocalized_04() {

        XCTAssertEqual("SecondTest".localized, "The first and second words are only for test purpose")
    }

}
