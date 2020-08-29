//
//  RemoteHandlerTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 28/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
@testable import PruebaMapsCore

// MARK: - URLSessionDataTaskMock

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}

// MARK: - URLSessionMock

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    init(configuration: URLSessionConfiguration? = nil) {}

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

class RemoteHandlerTest: XCTestCase {

    // MARK: - Constants

    private enum Constants {
        static let baseURL: URL = URL(string: "www.test.com")!
    }

    // MARK: - Variables

    var session: URLSessionMock!
    var remoteHandler: RemoteHandler!

    var pointRequest: PointRequest!

    // MARK: - Lifecycle Methods

    override func setUp() {
        super.setUp()

        session = URLSessionMock()
        remoteHandler = RemoteHandler(session: session)

        let lowerLeft = Coordinates(latitud: 10.3,
                                    longitud: -10.3)

        let upperRight = Coordinates(latitud: 40.42,
                                     longitud: -40.42)

        pointRequest = PointRequest(zone: "madrid",
                                    lowerLeft: lowerLeft,
                                    upperRight: upperRight)
    }

    // MARK: - Tests

    func testRemoteHandler_01() {

        let error = NSError(domain: "domain", code: 000, userInfo: nil)
        session.error = error

        var remoteError: RemoteError?
        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in
                            switch result {
                            case .success:
                                remoteError = nil
                            case .failure(let error):
                                remoteError = error
                            }
        }
        if let remoteError = remoteError {
            XCTAssertEqual(remoteError.errorDescription, RemoteError.unexpected.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }

    }

    func testRemoteHandler_02() {

        var remoteError: RemoteError?
        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in
                            switch result {
                            case .success:
                                remoteError = nil
                            case .failure(let error):
                                remoteError = error
                            }

        }

        if let remoteError = remoteError {
            XCTAssertEqual(remoteError.errorDescription, RemoteError.internalServer.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func testRemoteHandler_03() {

        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 409,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response

        var remoteError: RemoteError?
        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in


                            switch result {
                            case .success:
                                remoteError = nil
                            case .failure(let error):
                                remoteError = error
                            }

        }
        if let remoteError = remoteError {
            XCTAssertEqual(remoteError.errorDescription, RemoteError.business.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func testRemoteHandler_04() {

        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response

        var remoteError: RemoteError?
        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in

                            switch result {
                            case .success:
                                remoteError = nil
                            case .failure(let error):
                                remoteError = error
                            }

        }

        if let remoteError = remoteError {
            XCTAssertEqual(remoteError.errorDescription, RemoteError.noContent.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func testRemoteHandler_05() {

        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response
        session.data = Data()

        var remoteError: RemoteError?
        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in

                            switch result {
                            case .success:
                                remoteError = nil
                            case .failure(let error):
                                remoteError = error
                            }

        }

        if let remoteError = remoteError {
            XCTAssertEqual(remoteError.errorDescription, RemoteError.mappingFailed.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

}
