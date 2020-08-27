//
//  PointRequest.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

public struct PointRequest {
    let zone: String
    let lowerLeft: Coordinates
    let upperRight: Coordinates

    public init(zone: String,
                lowerLeft: Coordinates,
                upperRight:Coordinates) {
        self.zone = zone
        self.lowerLeft = lowerLeft
        self.upperRight = upperRight
    }
}

public struct Coordinates {
    let latitud: Double
    let longitud: Double

    public init(latitud: Double,
                longitud: Double) {
        self.latitud = latitud
        self.longitud = longitud
    }

}
