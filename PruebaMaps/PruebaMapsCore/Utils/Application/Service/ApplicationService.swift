//
//  ApplicationService.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 12/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public struct ApplicationService {

    // MARK: - Fields

    public static var sharedInstance: ApplicationService = ApplicationService()

    private let disposeBag = DisposeBag()

    // MARK: - Constants

    private enum Constants {

        static var didOpenAppCountKey = "didOpenAppCountKey"
        static var previousAppVersionKey = "previousAppVersionKey"
        static var currentAppVersionKey = "currentAppVersionKey"

        static var currentAppVersionValue = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    // MARK: - init

    private init() {
        setupBindings()
    }

    private func setupBindings() {

        UIApplication.shared.rx.didOpenApp
            .subscribe(onNext: updateApplicationStats)
            .disposed(by: disposeBag)

    }

    private func updateApplicationStats() {
        let userDefaults = UserDefaults.standard

        var count = userDefaults.integer(forKey: Constants.didOpenAppCountKey)
        count = min(count + 1, Int.max - 1)
        userDefaults.set(count, forKey: Constants.didOpenAppCountKey)

        let previousAppVersion = userDefaults.string(forKey: Constants.currentAppVersionKey) ?? Constants.currentAppVersionValue
        let currentAppVersion = Constants.currentAppVersionValue
        userDefaults.set(previousAppVersion, forKey: Constants.previousAppVersionKey)
        userDefaults.set(currentAppVersion, forKey: Constants.currentAppVersionKey)

    }

    lazy var didOpenAppCount: Observable<Int> = UIApplication.shared.rx.didOpenApp
    .map { _ in
        return UserDefaults.standard.integer(forKey: Constants.didOpenAppCountKey)
    }
    .share(replay: 1, scope: .forever)

    lazy var isFirstLaunch: Observable<Bool> = UIApplication.shared.rx.didOpenApp
        .map { _ in
            let didOpenAppCount = UserDefaults.standard.integer(forKey: Constants.didOpenAppCountKey)
            return didOpenAppCount == 1
    }
    .share(replay: 1, scope: .forever)

    lazy var firstLaunch: Observable<Void> = UIApplication.shared.rx.isFirstLaunch
        .filter { $0 }
        .map { _ in return }

    lazy var appVersion: Observable<ApplicationVersion> = UIApplication.shared.rx.didOpenApp
        .map { _ in
            let userDefaults = UserDefaults.standard
            let currentVersion: String = userDefaults.string(forKey: Constants.currentAppVersionKey) ?? Constants.currentAppVersionValue ?? ""
            let previousVersion: String = userDefaults.string(forKey: Constants.previousAppVersionKey) ?? currentVersion
            return ApplicationVersion(previous: previousVersion, current: currentVersion)
        }
        .share(replay: 1, scope: .forever)

    lazy var isFirstLaunchOfNewVersion: Observable<Bool> = appVersion
        .map { version in
            return version.previous != version.current
        }

    lazy var firstLaunchOfNewVersion: Observable<ApplicationVersion> = appVersion
        .filter { $0.previous != $0.current }

}
