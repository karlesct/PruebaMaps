//
//  PointElement.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

// MARK: - PointElement

typealias Point = [PointElement]

struct PointElement: Codable {
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
        case pointX = "x"
        case pointY = "y"
        case companyZoneID = "companyZoneId"
        case lat, lon, licencePlate, range, batteryLevel, seats, model
        case resourceImageID = "resourceImageId"
        case realTimeData, resourceType, helmets, station
        case availableResources, spacesAvailable, allowDropoff, bikesAvailable
    }
}
