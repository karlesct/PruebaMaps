//
//  FirstPresenter.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

import Foundation

internal protocol FirstViewProtocol: class {
    var title: String? { get set }
    func setLoading(_ loading: Bool)
}

internal protocol FirstPresenterProtocol: class {

    var view: FirstViewProtocol? { get set }
    func loadView()
    func fetchPoints()

}

internal final class FirstPresenter: FirstPresenterProtocol {

    // MARK: - Properties

    private let repository: FirstRepositoryProtocol

    // MARK: - Fields

    weak var view: FirstViewProtocol?

    // MARK: - Init

    init(repository: FirstRepositoryProtocol) {
        self.repository = repository
    }

    func loadView() {

        view?.title = "Maps"

    }

    func fetchPoints() {
        
    }
}
