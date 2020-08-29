//
//  FirstRespositoryTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 29/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class FirstRespositoryTest: XCTestCase {

    // MARK: - Constants

    private enum Constants {
        static let baseURL: URL = URL(string: "www.test.com")!
        static let timeout: TimeInterval = 5
    }

    // MARK: - Variables

    private var session: URLSessionMock!
    private var remoteHandler: RemoteHandler!
    private var repository: FirstRepository!

    var pointRequest: PointRequest!

    // MARK: - Lifecycle Methods

    override func setUp() {
        super.setUp()

        session = URLSessionMock()
        remoteHandler = RemoteHandler(session: session)

        let lowerLeft = Coordinates(latitud: 10.3,
                                    longitud: -10.3)

        let upperRight = Coordinates(latitud: 40.42,
                                     longitud: -40.42)

        pointRequest = PointRequest(zone: "madrid",
                                    lowerLeft: lowerLeft,
                                    upperRight: upperRight)
    }

    func testFirstRespository_01() {

        // Given
        session = URLSessionMock()
        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response

        let pointsElementResponse = [PointElementResponse(id: "testID",
                                                          name: "testName",
                                                          pointX: 10.1, pointY: 10.2,
                                                          scheduledArrival: 1,
                                                          locationType: 2, companyZoneID: 3,
                                                          lat: 1.4, lon: 1.5,
                                                          licencePlate: "testPlate",
                                                          range: 10,
                                                          batteryLevel: 11, seats: 12,
                                                          model: "testModel",
                                                          resourceImageID: "testResourceImageID",
                                                          realTimeData: true,
                                                          resourceType: "testResourceType",
                                                          helmets: 13, station: false,
                                                          availableResources: 14,
                                                          spacesAvailable: 15, allowDropoff: true,
                                                          bikesAvailable: 16)]
        let encoder = JSONEncoder()

        let data = try? encoder.encode(pointsElementResponse)

        session.data = data
        remoteHandler = RemoteHandler(session: session)
        repository = FirstRepository(remoteHandler: remoteHandler)

        // When
        let repositoryExpectation = expectation(description: "FirstRepositoryExpectationSuccess")
        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in

                            switch result {
                            case .success(let points):
                                // Then
                                XCTAssertEqual(points.count, 1)
                                repositoryExpectation.fulfill()
                            case .failure:
                                XCTFail("FirstepositoryTests failed when expected to succeed")
                            }
        }

        // Then
        waitForExpectations(timeout: Constants.timeout) { error in

            if let error = error {
                XCTFail("FirstRepositoryTests error: \(error)")
            }
        }
    }

    func testFirstRespository_02() {

        // Given
        session = URLSessionMock()
        let error = NSError(domain: "domain", code: 000, userInfo: nil)
        session.error = error
        remoteHandler = RemoteHandler(session: session)
        repository = FirstRepository(remoteHandler: remoteHandler)

        // When
        let repositoryExpectation = expectation(description: "FirstRepositoryExpectationFailure")

        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in

                            switch result {
                            case .success:
                                XCTFail("FirstepositoryTests succeeded when expected to fail")

                            case .failure(let error):
                                XCTAssertNotNil(error)
                                repositoryExpectation.fulfill()
                            }
        }

        // Then
        waitForExpectations(timeout: Constants.timeout) { error in

            if let error = error {
                XCTFail("FirstRepositoryTests error: \(error)")
            }
        }
    }

}
