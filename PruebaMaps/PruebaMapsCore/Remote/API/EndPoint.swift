//
//  EndPoint.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//


import Foundation

internal enum Endpoint {
    case getPoints(pointRequest: PointRequest)

    var method: HTTPMethods {
        switch self {
        case .getPoints:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getPoints(let pointRequest):
            return "/routers/\(pointRequest.zone)/resources"
        }
    }

    var parameters: [String: String] {
        switch self {
        case .getPoints(let pointRequest):
            return ["lowerLeftLatLon": "\(pointRequest.lowerLeft.latitud),\(pointRequest.lowerLeft.longitud)",
                    "upperRightLatLon": "\(pointRequest.upperRight.latitud),\(pointRequest.upperRight.longitud)"]
        }
    }

    func request(with baseURL: URL, adding parameters: [String: String]) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        var newParameters = self.parameters
        parameters.forEach { newParameters.updateValue($1, forKey: $0) }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = newParameters.map(URLQueryItem.init)

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue

        return request
    }

}
