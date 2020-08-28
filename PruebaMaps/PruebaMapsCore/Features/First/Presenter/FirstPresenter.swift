//
//  FirstPresenter.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

internal protocol FirstViewProtocol: class {
    var title: String? { get set }
    func setLoading(_ loading: Bool)
    func setUserLocation(location: CLLocation?)
}

internal protocol FirstPresenterProtocol: class {

    var view: FirstViewProtocol? { get set }
    func loadView()
    func didAppearView()
    func fetchPoints(zone: String, loweLeft: CLLocationCoordinate2D, upperRight: CLLocationCoordinate2D)

}

internal final class FirstPresenter: FirstPresenterProtocol {

    // MARK: - Properties

    private let repository: FirstRepositoryProtocol
    private var locationService: LocationServiceProtocol

    // MARK: - Fields

    weak var view: FirstViewProtocol?

    // MARK: - Init

    init(repository: FirstRepositoryProtocol,
         locationService: LocationServiceProtocol) {
        self.repository = repository
        self.locationService = locationService
    }

    func loadView() {

        view?.title = "Maps"

    }

    func didAppearView() {

        locationService.delegate = self

    }

    func fetchPoints(zone: String,
                     loweLeft: CLLocationCoordinate2D,
                     upperRight: CLLocationCoordinate2D) {

        let lowerLeft = Coordinates(latitud: Float(loweLeft.latitude), longitud: Float(loweLeft.longitude))
        let upperRight = Coordinates(latitud: Float(upperRight.latitude), longitud: Float(upperRight.longitude))
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

extension FirstPresenter: LocationServiceDelegate {

    func userLocation(manager: CLLocationManager) {
        view?.setUserLocation(location: manager.location)
    }

}
