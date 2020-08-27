//
//  CoreAssembly.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

public final class CoreAssembly {

    // MARK: - Fields
    private let navigationController: UINavigationController

    // MARK: - Properties

    private(set) lazy var remoteAssembly = RemoteAssembly()

    public private(set) lazy var firstAssembly = FirstAssembly(navigationController: navigationController,
                                                               remoteAssembly: remoteAssembly)

    // MARK: - Init
    public init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

}

