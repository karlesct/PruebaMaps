//
//  RemoteHandler.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

internal final class RemoteHandler {

    // MARK: - Properties
    private let session: URLSession
    private let decoder = JSONDecoder()

    // MARK: - Variables
    private var dataTask: URLSessionDataTask?

    // MARK: - Initializers
    init(session: URLSession) {
        self.session = session
    }

    // MARK: - Internal Methods
    func load<T>(_ type: T.Type,
                 from endpoint: Endpoint,
                 completion completed: @escaping (Result<T, RemoteError>) -> Void) where T: Decodable {

        let decoder = self.decoder

        guard let urlRequest = endpoint.asURLRequest() else {
            completed(.failure(.internalServer))
            return
        }

        dataTask = session.dataTask(with: urlRequest,
                                    completionHandler: { data, response, error in

            if let error = error {
                completed(.failure(RemoteError.mapServiceError(error: error as NSError)))
            } else {

                guard let httpResponse = response as? HTTPURLResponse else {
                    completed(.failure(.internalServer))
                    return
                }

                if 200 ..< 300 ~= httpResponse.statusCode {
                    if let data = data {
                        if let result = try? decoder.decode(T.self, from: data) {
                            completed(.success(result))
                        } else {
                            completed(.failure(.mappingFailed))
                        }
                    } else {
                        completed(.failure(.noContent))
                    }

                } else {
                    let error = NSError(domain: .empty, code: httpResponse.statusCode)
                    completed(.failure(RemoteError.mapServiceError(error: error)))
                }
            }
        })

        dataTask?.resume()
    }

}
