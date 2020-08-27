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

    // MARK: - Init

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods

    public func viewController() -> UIViewController {

        return FirstViewController(presenter: presenter())

    }

    // MARK: - Internal Methods

    func presenter() -> FirstPresenterProtocol {

        return FirstPresenter()
    }


}
