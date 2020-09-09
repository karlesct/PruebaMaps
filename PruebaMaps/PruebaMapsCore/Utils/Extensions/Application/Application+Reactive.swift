//
//  Application+Reactive.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 08/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public enum UIApplicationStatus: Equatable {

    case active     // The application is running in the foreground
    case inactive   // The application is running in the foreground but not receiving events
    case background // The application is in the background because the user closed it
    case terminated // The application is about to be terminated by the system
}

public extension Reactive where Base: UIApplication {

    // MARK: - Life cycle

    var applicationDidBecomeActive: ControlEvent<UIApplicationStatus> {
        let source = NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification)
            .map { _ in
                return UIApplicationStatus.active
        }
        return ControlEvent(events: source)
    }

    var applicationWillResignActive: ControlEvent<UIApplicationStatus> {
        let source = NotificationCenter.default.rx.notification(UIApplication.willResignActiveNotification)
            .map { _ in
                return UIApplicationStatus.inactive
        }
        return ControlEvent(events: source)
    }

    var applicationWillEnterForeground: ControlEvent<UIApplicationStatus> {
        let source = NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
            .map { _ in
                return UIApplicationStatus.inactive
        }
        return ControlEvent(events: source)
    }

    var applicationDidEnterBackground: ControlEvent<UIApplicationStatus> {
        let source = NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification)
            .map { _ in
                return UIApplicationStatus.background
        }
        return ControlEvent(events: source)
    }

    var applicationWillTerminate: ControlEvent<UIApplicationStatus> {
        let source =  NotificationCenter.default.rx.notification(UIApplication.willTerminateNotification)
            .map { _ in
                return UIApplicationStatus.terminated
        }
        return ControlEvent(events: source)
    }

}
