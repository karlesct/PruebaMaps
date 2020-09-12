//
//  BasePresenter.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 11/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

public protocol BasePresenterProtocol: class {

    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewDidLayoutSubviews()

}

open class BasePresenter: BasePresenterProtocol {

    open func viewDidLoad() {}
    open func viewWillAppear() {}
    open func viewDidAppear() {}
    open func viewWillDisappear() {}
    open func viewDidDisappear() {}
    open func viewDidLayoutSubviews() {}

}
