//
//  PointElement.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps

// MARK: - PointElement

typealias PointsElementResponse = [PointElementResponse]

struct PointElementResponse: Codable {
    let id, name: String
    let pointX, pointY: Float
    let scheduledArrival, locationType: Int?
    let companyZoneID: Int
    let lat, lon: Float?
    let licencePlate: String?
    let range, batteryLevel, seats: Int?
    let model: String?
    let resourceImageID: String?
    let realTimeData: Bool?
    let resourceType: String?
    let helmets: Int?
    let station: Bool?
    let availableResources, spacesAvailable: Int?
    let allowDropoff: Bool?
    let bikesAvailable: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, scheduledArrival, locationType
        case pointX = "x"   // is the same than longitude
        case pointY = "y"   // is the same than latitude
        case companyZoneID = "companyZoneId"
        case lat, lon, licencePlate, range, batteryLevel, seats, model
        case resourceImageID = "resourceImageId"
        case realTimeData, resourceType, helmets, station
        case availableResources, spacesAvailable, allowDropoff, bikesAvailable
    }
}

typealias Points = [PointElement]

struct PointElement: Equatable {
    let id: String
    let name: String
    let lat: String
    let lon: String
    let companyZoneID: Int
    let marker: GMSMarker

    init(id: String, name: String, lat: Float, lon: Float, companyZoneID: Int, marker: GMSMarker) {
        self.id = String(format: "id".localized, id)
        self.name = name
        self.lat = String(format: "latitude".localized, lat)
        self.lon = String(format: "longitude".localized, lon)
        self.companyZoneID = companyZoneID
        self.marker = marker
    }
}

struct UniqueCompanyZoneIDWithColor {
    let companyZoneID: Int
    let color: UIColor
}

internal final class PointElementBinding {

    static func bind(_ pointElementResponse: PointsElementResponse) -> Points {

        var points: [PointElement] = []

        let uniqueCategories = pointElementResponse
            .compactMap { $0.companyZoneID }
            .distinct()

        var uniqueCompanyZoneIDWithColor: [UniqueCompanyZoneIDWithColor] = []

        uniqueCategories.forEach { item in

            let element = UniqueCompanyZoneIDWithColor(companyZoneID: item, color: UIColor.random)
            uniqueCompanyZoneIDWithColor.append(element)
        }

        pointElementResponse.forEach { item in
            let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(item.pointY),
                                                  longitude: CLLocationDegrees(item.pointX))
            let marker = GMSMarker(position: position)

            let color = uniqueCompanyZoneIDWithColor.first(where: {$0.companyZoneID == item.companyZoneID})?.color
            marker.icon = GMSMarker.markerImage(with: color)

            let pointElement = PointElement(id: item.id,
                                            name: item.name,
                                            lat: item.pointY,
                                            lon: item.pointX,
                                            companyZoneID: item.companyZoneID,
                                            marker: marker)

            marker.title = pointElement.name
            marker.snippet = [pointElement.id,
                              pointElement.lat,
                              pointElement.lon]
                .compactMap { $0 }
                .joined(separator: ", ")

            points.append(pointElement)

        }
        return points

    }

}
