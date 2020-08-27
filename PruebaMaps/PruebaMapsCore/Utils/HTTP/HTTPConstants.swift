//
//  HTTPConstants.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

internal enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

internal enum HTTPHeader: String {
    case contentType = "Content-Type"
}

enum HTTPHeaderContentTypeValue: String {
    case json = "application/json"
    case xWwwFormUrlEncoded = "application/x-www-form-urlencoded"
}
