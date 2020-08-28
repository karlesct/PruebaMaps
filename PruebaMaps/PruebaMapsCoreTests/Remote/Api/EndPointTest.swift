//
//  EndPointTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 28/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class EndPointTest: XCTestCase {

    // MARK: - Constants

    private enum Constants {
        static let baseURL: URL = URL(string: "www.test.com")!
    }

    var pointRequest: PointRequest!

    override func setUp() {
        super.setUp()

        let lowerLeft = Coordinates(latitud: 10.3,
                                    longitud: -10.3)

        let upperRight = Coordinates(latitud: 40.42,
                                     longitud: -40.42)

        pointRequest = PointRequest(zone: "madrid",
                                    lowerLeft: lowerLeft,
                                    upperRight: upperRight)

    }

    func testEndPoint_01() {

        let endpoint: Endpoint = .getPoints(pointRequest: pointRequest)
        let request = endpoint.request(with: Constants.baseURL, adding: [:])
        XCTAssertNotNil(request)
        XCTAssertEqual(request.url?.path, "www.test.com/routers/madrid/resources")
        XCTAssertEqual(request.httpMethod, "GET")
    }

}
