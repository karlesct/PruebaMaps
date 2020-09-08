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
import GoogleMaps
import RxSwift
import RxCocoa

internal protocol FirstPresenterProtocol: class {

    var titlePageObservable: Observable<String> { get }
    var titlePageSubject: BehaviorSubject<String> { get set }

    var pointsObservable: Observable<Points> { get }
    var pointsSubject: BehaviorSubject<Points> { get set }

    var locationObservable: Observable<CLLocation?> { get }
    var locationSubject: BehaviorSubject<CLLocation?> { get set }

    func viewDidLoad()
    func viewDidAppear()

    func fetchPoints(zone: String, loweLeft: CLLocationCoordinate2D, upperRight: CLLocationCoordinate2D)

}

internal final class FirstPresenter: FirstPresenterProtocol {

    // MARK: - Properties

    private let repository: FirstRepositoryProtocol
    private var locationService: LocationServiceProtocol

    private var disposeBag: DisposeBag?

    // Points

    internal var titlePageSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: .empty)
    public var titlePageObservable: Observable<String> {
        return titlePageSubject.asObservable()
    }

    // Points

    internal var pointsSubject: BehaviorSubject<Points> = BehaviorSubject<Points>(value: [])
    public var pointsObservable: Observable<Points> {
        return pointsSubject.asObservable()
    }

    // Location

    internal var locationSubject: BehaviorSubject<CLLocation?> = BehaviorSubject<CLLocation?>(value: nil)
    public var locationObservable: Observable<CLLocation?> {
        return locationSubject.asObservable()
    }

    // MARK: - Fields

    // MARK: - Init

    init(repository: FirstRepositoryProtocol,
         locationService: LocationServiceProtocol) {

        self.repository = repository
        self.locationService = locationService

        self.disposeBag = DisposeBag()
    }

    deinit {

        self.disposeBag = nil

    }

    func viewDidLoad() {

        self.titlePageSubject.onNext("Maps")
    }

    func viewDidAppear() {

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
            switch result {
            case .success(let points):
                self.pointsSubject.onNext(points)
            case .failure(let error):
                print(error)
            }
        })

    }
}

extension FirstPresenter: LocationServiceDelegate {

    func userLocation(manager: CLLocationManager) {
        self.locationSubject.onNext(manager.location)
    }

}
