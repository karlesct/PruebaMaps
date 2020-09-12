//
//  BaseViewController.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 11/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import RxSwift

public protocol BaseViewControllerProtocol: class {

    func setupBindings()

}

open class BaseViewController<T: BasePresenterProtocol>: UIViewController, BaseViewControllerProtocol {

    let presenter: T

    private (set) var disposeBag: DisposeBag?

    // MARK: - Init

    init(with presenter: T) {
        self.presenter = presenter

        self.disposeBag = DisposeBag()

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))

        self.setupBindings()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.disposeBag = nil
    }

    // MARK: - Private methods

    open func setupBindings() {

        guard let disposeBag = disposeBag else { return }

        // ViewDidLoad

        self.rx.viewDidLoad
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.presenter.viewDidLoad()
            })
            .disposed(by: disposeBag)

        // viewWillAppear

        self.rx.viewWillAppear
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.presenter.viewWillAppear()
            })
            .disposed(by: disposeBag)

        // viewDidAppear

        self.rx.viewDidAppear
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.presenter.viewDidAppear()
            })
            .disposed(by: disposeBag)

        // viewWillDisappear

        self.rx.viewWillDisappear
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.presenter.viewWillDisappear()
            })
            .disposed(by: disposeBag)

        // viewDidDisappear

        self.rx.viewDidDisappear
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.presenter.viewDidDisappear()
            })
            .disposed(by: disposeBag)

        // viewDidLayoutSubviews

        self.rx.viewDidLayoutSubviews
            .subscribe({ [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.presenter.viewDidLayoutSubviews()
            })
            .disposed(by: disposeBag)
    }

}
