//
//  FirstPresenter.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

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

        fetchPoints()

    }

    func fetchPoints() {

        let zone = "lisboa"
        let lowerLeft = Coordinates(latitud: 38.711046, longitud: -9.160096)
        let upperRight = Coordinates(latitud: 38.739429, longitud: -9.137115)
        let pointRequest = PointRequest(zone: zone,
                                        lowerLeft: lowerLeft,
                                        upperRight: upperRight)

        repository.getPoints(pointRequest: pointRequest,
                             completion: { [weak self] result in
            guard let `self` = self else { return }
            self.view?.setLoading(false)
            switch result {
            case .success(let point):
                print(point)
            case .failure(let error):
                print(error)
            }
        })

    }
}
