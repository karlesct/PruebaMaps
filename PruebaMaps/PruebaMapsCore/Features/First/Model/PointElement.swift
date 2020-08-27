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
    let x, y: Float
    let scheduledArrival, locationType: Int?
    let companyZoneID: Int
    let lat, lon: Float?
    let licencePlate: String?
    let range, batteryLevel, seats: Int?
    let model: Model?
    let resourceImageID: ResourceImageID?
    let realTimeData: Bool?
    let resourceType: ResourceType?
    let helmets: Int?
    let station: Bool?
    let availableResources, spacesAvailable: Int?
    let allowDropoff: Bool?
    let bikesAvailable: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, x, y, scheduledArrival, locationType
        case companyZoneID = "companyZoneId"
        case lat, lon, licencePlate, range, batteryLevel, seats, model
        case resourceImageID = "resourceImageId"
        case realTimeData, resourceType, helmets, station, availableResources, spacesAvailable, allowDropoff, bikesAvailable
    }
}

enum Model: String, Codable {
    case askoll = "Askoll"
    case nullDS3 = "null DS3"
}

enum ResourceImageID: String, Codable {
    case vehicleGenEcooltra = "vehicle_gen_ecooltra"
    case vehicleGenEmov = "vehicle_gen_emov"
}

enum ResourceType: String, Codable {
    case electricCar = "ELECTRIC_CAR"
    case moped = "MOPED"
}
