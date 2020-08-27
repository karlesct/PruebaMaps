//
//  CustomNavigationController.swift
//  PruebaMaps
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

internal final class CustomNavigationController: UINavigationController {

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Helpers

    private func setup() {

        self.delegate = self

    }

}

extension CustomNavigationController: UINavigationControllerDelegate {

    // MARK: - Delegate

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {

        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item

    }
}
