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

    // MARK: - Others

    var isFirstLaunch: Observable<Bool> {
        return base._sharedRxAppState.isFirstLaunch
    }

    var didOpenApp: ControlEvent<Void> {
        let source = Observable.of( applicationDidBecomeActive,
                                    applicationDidEnterBackground )
            .merge()
            .distinctUntilChanged()
            .filter { $0 == .active }
            .map { _ in
                return
        }
        return ControlEvent(events: source)
    }

}

private struct _SharedRxAppState {

    // MARK: - Fields

    let reactive: Reactive<UIApplication>
    let disposeBag = DisposeBag()

    // MARK: - Constants

    private enum Constants {

        static var didOpenAppCountKey = "didOpenAppCountKey"
        static var previousAppVersionKey = "previousAppVersionKey"
        static var currentAppVersionKey = "currentAppVersionKey"
    }

    // MARK: - init

    init(_ application: UIApplication) {
        reactive = application.rx
        reactive.didOpenApp
            .subscribe(onNext: updateAppStats)
            .disposed(by: disposeBag)
    }

    private func updateAppStats() {
        let userDefaults = UserDefaults.standard

        var count = userDefaults.integer(forKey: Constants.didOpenAppCountKey)
        count = min(count + 1, Int.max - 1)
        userDefaults.set(count, forKey: Constants.didOpenAppCountKey)

    }

    lazy var isFirstLaunch: Observable<Bool> = reactive.didOpenApp
        .map { _ in
            let didOpenAppCount = UserDefaults.standard.integer(forKey: Constants.didOpenAppCountKey)
            return didOpenAppCount == 1
    }
    .share(replay: 1, scope: .forever)

}

private var _sharedRxAppStateKey: UInt8 = 0
extension UIApplication {
    fileprivate var _sharedRxAppState: _SharedRxAppState {
        get {
            if let stored = objc_getAssociatedObject(self, &_sharedRxAppStateKey) as? _SharedRxAppState {
                return stored
            }
            let defaultValue = _SharedRxAppState(self)
            self._sharedRxAppState = defaultValue
            return defaultValue
        }
        set {
            objc_setAssociatedObject(self, &_sharedRxAppStateKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
