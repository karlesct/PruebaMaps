//
//  Bundle+IdentifiersTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class Bundle_IdentifiersTest: XCTestCase {

    func testBundleIdentifier_01() {

        let bundleIdentifier = "es.carlescanadastorrents.PruebaMaps"

        XCTAssertEqual(Bundle.AppIdentifier?.bundleIdentifier, bundleIdentifier)

    }

    func testBundleIdentifier_02() {

        let bundleIdentifier = "es.carlescanadastorrents.PruebaMapsCore"

        XCTAssertEqual(Bundle.CoreIdentifier?.bundleIdentifier, bundleIdentifier)

    }

}
