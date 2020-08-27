//
//  ViewController+GetTopViewControllerTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class ViewController_GetTopViewControllerTest: XCTestCase {

    var viewController: UIViewController!

    override func setUp() {
        super.setUp()

        viewController = UIViewController().getTopViewController

    }

    func testGetTopViewController_01() {
        XCTAssertNotNil(viewController)
    }

}
