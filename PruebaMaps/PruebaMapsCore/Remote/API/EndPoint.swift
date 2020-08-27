//
//  EndPoint.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//


import Foundation

/// Types adopting the `URLRequestConvertible` protocol can be used to safely construct `URLRequest`s.
public protocol URLRequestConvertible {
    /// Returns a `URLRequest` or return `nil`  if error was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() -> URLRequest?
}

internal enum Endpoint: URLRequestConvertible {
    case getPoints(pointRequest: PointRequest)

    static let baseURL = "https://apidev.meep.me"
    static let baseURLPath = "/tripplan/api/v1/"

    var method: HTTPMethods {
        switch self {
        case .getPoints:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getPoints(let pointRequest):
            return "/routers/\(pointRequest.zone)/resources?lowerLeftLatLon=\(pointRequest.lowerLeft.latitud),\(pointRequest.lowerLeft.longitud)&upperRightLatLon=\(pointRequest.upperRight.latitud),\(pointRequest.upperRight.longitud)"
        }
    }

    func asURLRequest() -> URLRequest? {

        let baseUrl = Endpoint.baseURL
        let path = Endpoint.baseURLPath + self.path

        guard let url = URL.init(string: baseUrl) else { return nil }

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.httpMethod = self.method.rawValue

       return urlRequest
    }

}
