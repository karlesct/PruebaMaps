//
//  RemoteError.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

public enum RemoteError: LocalizedError {

    case mappingFailed
    case unexpected
    case noNetwork
    case business
    case internalServer
    case timedOut
    case noContent
    case unknown(error: NSError)

    // MARK: - Variables
    public var errorDescription: String? {
        switch self {
        case .mappingFailed:
            return "core_serviceError_mappingFailed".localized
        case .unexpected, .business:
            return "core_serviceError_unexpected".localized
        case .noNetwork:
            return "core_serviceError_noNetwork".localized
        case .internalServer:
            return "core_serviceError_internalServer".localized
        case .timedOut:
            return "core_serviceError_timedOut".localized
        case .noContent:
            return "core_serviceError_noContent".localized
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    // MARK: - Internal Methods
    static func mapServiceError(error: NSError) -> RemoteError {

        switch error.code {
        case 000:
            return .unexpected
        case 001, -60, -1009:
            return .noNetwork
        case 409:
            return .business
        case 500, -1011:
            return .internalServer
        case -1001:
            return .timedOut
        case -1014:
            return .noContent
        default:
            return .unknown(error: error)
        }
    }
}
