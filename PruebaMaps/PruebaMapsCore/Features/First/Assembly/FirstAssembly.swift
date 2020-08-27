//
//  FirstAssembly.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

public final class FirstAssembly {

    // MARK: - Properties

    private let navigationController: UINavigationController
    private let remoteAssembly: RemoteAssembly

    // MARK: - Init

    public init(navigationController: UINavigationController,
                remoteAssembly: RemoteAssembly) {
        self.navigationController = navigationController
        self.remoteAssembly = remoteAssembly

    }

    // MARK: - Public Methods

    public func viewController() -> UIViewController {

        return FirstViewController(presenter: presenter())

    }

    // MARK: - Internal Methods

    func presenter() -> FirstPresenterProtocol {

        return FirstPresenter(repository: repository(),
                              locationService: buildLocationService() )
    }

    func repository() -> FirstRepositoryProtocol {

        return FirstRepository(remoteHandler: remoteAssembly.remoteHandler)

    }

    func buildLocationService() -> LocationServiceProtocol {

        return LocationServiceAssembly().locationService

    }

}
