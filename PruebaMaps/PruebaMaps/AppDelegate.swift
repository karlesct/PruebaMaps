//
//  AppDelegate.swift
//  PruebaMaps
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Fields

    private let appAssembly = AppAssembly()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        appSetup()

        return true
    }

}

extension AppDelegate {

    func appSetup() {

        window = appAssembly.window

        let initialViewController = appAssembly.coreAssembly.firstAssembly.viewController()

        appAssembly.navigationController.pushViewController(initialViewController,
                                                            animated: false)

        appAssembly.window.rootViewController = appAssembly.navigationController

        appAssembly.window.makeKeyAndVisible()

    }

}
