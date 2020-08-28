//
//  RemoteErrorTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 28/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

class RemoteErrorTest: XCTestCase {

    func testRemoteError_01() {

        var errorDescription: String
        errorDescription = "Could not decode response as desired type"
        XCTAssertEqual(RemoteError.mappingFailed.errorDescription, errorDescription)
        errorDescription = "An error has occurred"
        XCTAssertEqual(RemoteError.unexpected.errorDescription, errorDescription)
        errorDescription = "An error has occurred"
        XCTAssertEqual(RemoteError.business.errorDescription, errorDescription)
        errorDescription = "The device has no connection to internet"
        XCTAssertEqual(RemoteError.noNetwork.errorDescription, errorDescription)
        errorDescription = "Connection received an invalid server response"
        XCTAssertEqual(RemoteError.internalServer.errorDescription, errorDescription)
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        errorDescription = "Unknown error"
        XCTAssertEqual(RemoteError.unknown(error: error).errorDescription, errorDescription)
        errorDescription = "Connection timed out"
        XCTAssertEqual(RemoteError.timedOut.errorDescription, errorDescription)
        errorDescription = "Connection retrieved no response"
        XCTAssertEqual(RemoteError.noContent.errorDescription, errorDescription)
    }

    func testRemoteError_02() {

        var error: NSError
        var description: String?
        error = NSError(domain: "", code: 000)
        description = RemoteError.unexpected.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: 001)
        description = RemoteError.noNetwork.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: -60)
        description = RemoteError.noNetwork.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: -1009)
        description = RemoteError.noNetwork.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: 409)
        description = RemoteError.business.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: 500)
        description = RemoteError.internalServer.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: -1011)
        description = RemoteError.internalServer.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: -998, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        description = RemoteError.unknown(error: error).errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: -1001)
        description = RemoteError.timedOut.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: -1014)
        description = RemoteError.noContent.errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
        error = NSError(domain: "", code: 9999999, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        description = RemoteError.unknown(error: error).errorDescription
        XCTAssertEqual(RemoteError.mapServiceError(error: error).errorDescription, description)
    }

}
