//
//  FirstRepository.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

internal protocol FirstRepositoryProtocol {
    func getPoints(pointRequest: PointRequest, completion completed: @escaping (Result<Points, RemoteError>) -> Void)
}

internal final class FirstRepository {

    // MARK: - Properties

    private let remoteHandler: RemoteHandler

    // MARK: - Init

    init(remoteHandler: RemoteHandler) {
        self.remoteHandler = remoteHandler
    }

}

extension FirstRepository: FirstRepositoryProtocol {

    func getPoints(pointRequest: PointRequest, completion completed: @escaping (Result<Points, RemoteError>) -> Void) {

        remoteHandler.load(PointsElementResponse.self,
                           from: .getPoints(pointRequest: pointRequest)) { result in

                            DispatchQueue.main.async {
                                switch result {
                                case .success(let point):
                                    let pointBind = PointElementBinding.bind(point)
                                    completed(.success(pointBind))
                                case .failure(let error):
                                    completed(.failure(error))
                                }
                            }
        }
    }

}
