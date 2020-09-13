//
//  ApplicationLifeCycle+Reactive.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 08/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// https://github.com/pixeldock/RxAppState/tree/master/Pod/Classes

public enum UIApplicationStatus: Equatable {

    case active     // The application is running in the foreground
    case inactive   // The application is running in the foreground but not receiving events
    case background // The application is in the background because the user closed it
    case terminated // The application is about to be terminated by the system
}

public extension Reactive where Base: UIApplication {

    // MARK: - Life cycle

    var applicationDidBecomeActive: Observable<UIApplicationStatus> {
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .map { _ in
                return .active
        }
    }

    var applicationWillResignActive: Observable<UIApplicationStatus> {
        NotificationCenter.default.rx.notification(UIApplication.willResignActiveNotification)
            .map { _ in
                return .inactive
        }
    }

    var applicationWillEnterForeground: Observable<UIApplicationStatus> {
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
            .map { _ in
                return .inactive
        }
    }

    var applicationDidEnterBackground: Observable<UIApplicationStatus> {
        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification)
            .map { _ in
                return .background
        }
    }

    var applicationWillTerminate: Observable<UIApplicationStatus> {
        NotificationCenter.default.rx.notification(UIApplication.willTerminateNotification)
            .map { _ in
                return .terminated
        }
    }

    // MARK: - Others

    var didOpenApp: Observable<Void> {
        Observable.of( applicationDidBecomeActive,
                       applicationDidEnterBackground )
            .merge()
            .distinctUntilChanged()
            .filter { $0 == .active }
            .map { _ in
                return
        }
    }

    var appVersion: Observable<ApplicationVersion> {
        return ApplicationService.sharedInstance.appVersion
    }

    var didOpenAppCount: Observable<Int> {
        return ApplicationService.sharedInstance.didOpenAppCount
    }

    var isFirstLaunch: Observable<Bool> {
        return ApplicationService.sharedInstance.isFirstLaunch
    }

    var firstLaunch: Observable<Void> {
        return ApplicationService.sharedInstance.firstLaunch
    }

    var isFirstLaunchOfNewVersion: Observable<Bool> {
        return ApplicationService.sharedInstance.isFirstLaunchOfNewVersion
    }

    var firstLaunchOfNewVersion: Observable<ApplicationVersion> {
        return ApplicationService.sharedInstance.firstLaunchOfNewVersion
    }

}
