//
//  PointElementTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 29/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class PointElementTest: XCTestCase {

    func testPointElement_01() {

        let pointsElementResponse = [PointElementResponse(id: "testID",
                                                         name: "testName",
                                                         pointX: 10.1,
                                                         pointY: 10.2,
                                                         scheduledArrival: 1,
                                                         locationType: 2,
                                                         companyZoneID: 3,
                                                         lat: 1.4,
                                                         lon: 1.5,
                                                         licencePlate: "testPlate",
                                                         range: 10,
                                                         batteryLevel: 11,
                                                         seats: 12,
                                                         model: "testModel",
                                                         resourceImageID: "testResourceImageID",
                                                         realTimeData: true,
                                                         resourceType: "testResourceType",
                                                         helmets: 13,
                                                         station: false,
                                                         availableResources: 14,
                                                         spacesAvailable: 15,
                                                         allowDropoff: true,
                                                         bikesAvailable: 16)]

        let points = PointElementBinding.bind(pointsElementResponse)

        XCTAssertEqual(points.count, 1)

        let point = points[0]
        XCTAssertEqual(point.id, String(format: "id".localized, "testID"))
        XCTAssertEqual(point.name, "testName")
        XCTAssertEqual(point.lat, String(format: "latitude".localized, 10.2))
        XCTAssertEqual(point.lon, String(format: "longitude".localized, 10.1))
        XCTAssertEqual(point.companyZoneID, 3)
    }

}
