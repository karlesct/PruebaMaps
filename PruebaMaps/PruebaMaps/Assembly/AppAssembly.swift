//
//  AppAssembly.swift
//  PruebaMaps
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

internal final class AppAssembly {

    // MARK: - Properties

    private(set) lazy var window = UIWindow(frame: UIScreen.main.bounds)
    private(set) lazy var navigationController: UINavigationController = {
        return CustomNavigationController()
    }()

}
