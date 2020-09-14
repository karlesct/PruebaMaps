//
//  AppDelegate.swift
//  PruebaMaps
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

// RxFlow: https://github.com/RxSwiftCommunity/RxFlow

import UIKit
import GoogleMaps
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Fields

    private let appAssembly = AppAssembly()
    private let disposeBag = DisposeBag()

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        appSetup()

        return true
    }

}

extension AppDelegate {

    func appSetup() {

        setupGoogleMaps()

        setupWindow()

        setupBindings()

    }

    func setupGoogleMaps() {
        GMSServices.provideAPIKey("AIzaSyAdE8r0bQcPQfye1dC_LKX16OWIuqPvYmU")
    }

    func setupWindow() {
        window = appAssembly.window

        // Hack to show splash until can show the first screen, the only solution that actually works
        appAssembly.window.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        appAssembly.window.makeKeyAndVisible()
    }

    func setupBindings() {

        UIApplication.shared.rx.isFirstLaunch
        .subscribe(onNext: { [weak self] isFirstLaunch in
            guard let strongSelf = self else { return }
            debugPrint("isFirstLaunch: \(isFirstLaunch)")
            let firstViewController = isFirstLaunch
                ? strongSelf.appAssembly.coreAssembly.walkthroughAssembly.viewController()
                : strongSelf.appAssembly.coreAssembly.walkthroughAssembly.viewController()
                //: strongSelf.appAssembly.coreAssembly.firstAssembly.viewController()

            strongSelf.presentViewController(firstViewController)

        }).disposed(by: disposeBag)

    }

    func presentViewController(_ firstViewController: UIViewController) {

        appAssembly.navigationController.pushViewController(firstViewController,
                                                            animated: false)

        appAssembly.window.rootViewController = appAssembly.navigationController

        appAssembly.window.makeKeyAndVisible()

    }

}
