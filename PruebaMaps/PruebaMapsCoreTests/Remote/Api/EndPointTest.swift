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

        let lowerLeft = Coordinates(latitud: 40.42662,
                                    longitud: -3.65859)

        let upperRight = Coordinates(latitud: 40.42437,
                                     longitud: -3.71183)

        pointRequest = PointRequest(zone: "madrid",
                                    lowerLeft: lowerLeft,
                                    upperRight: upperRight)

    }

    func test_current() {

        let endpoint: Endpoint = .getPoints(pointRequest: pointRequest)
        let request = endpoint.request(with: Constants.baseURL, adding: [:])
        XCTAssertNotNil(request)
        XCTAssertEqual(request.url?.path, "www.test.com/routers/madrid/resources")
        XCTAssertEqual(request.url?.absoluteString, "www.test.com/routers/madrid/resources?lowerLeftLatLon=40.42662,-3.65859&upperRightLatLon=40.42437,-3.71183")
        XCTAssertEqual(request.httpMethod, "GET")
    }

}
