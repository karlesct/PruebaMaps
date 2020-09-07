//
//  FirstPresenterTest.swift
//  PruebaMapsCoreTests
//
//  Created by Carles Cañadas Torrents on 07/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest
import GoogleMaps

@testable import PruebaMapsCore

class FirstRepositoryMock: FirstRepositoryProtocol {
    
    func getPoints(pointRequest: PointRequest, completion completed: @escaping (Result<Points, RemoteError>) -> Void) {

        let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(10.1),
                                              longitude: CLLocationDegrees(10.2))
        let marker = GMSMarker(position: position)

        let points: [PointElement] = [PointElement(id: "testID",
                                                   name: "testName",
                                                   lat: 1.4,
                                                   lon: 1.5,
                                                   companyZoneID: 3,
                                                   marker: marker)]
        completed(.success(points))

    }

}

class LocationServiceMock: LocationServiceProtocol {
    var delegate: LocationServiceDelegate?

}

class FirstPresenterTest: XCTestCase {

    // MARK: - Variables

    private var disposeBag: DisposeBag!
    private var repository: FirstRepositoryMock!
    private var presenter: FirstPresenter!
    private var locationService: LocationServiceMock!
    private var testScheduler: TestScheduler!
    private var scheduler: ConcurrentDispatchQueueScheduler!
    var pointRequest: PointRequest!

    // MARK: - Lifecycle Methods

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        repository = FirstRepositoryMock()
        locationService = LocationServiceMock()
        presenter = FirstPresenter(repository: repository,
                                   locationService: locationService)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        disposeBag = nil
        repository = nil
        locationService = nil
        presenter = nil
        testScheduler = nil
        super.tearDown()
    }

    func testFirstPresenter_01() {
        let title = testScheduler.createObserver(String.self)

        presenter.titlePageObservable.bind(to: title).disposed(by: disposeBag)

        XCTAssertRecordedElements(title.events, [""])

    }

    func testFirstPresenter_02() {
        let title = presenter.titlePageObservable.subscribeOn(scheduler)

        presenter.titlePageSubject.onNext("Map")

        XCTAssertEqual(try title.toBlocking().first(),"Map")

    }

    func testFirstPresenter_03() {
        let title = presenter.locationObservable.subscribeOn(scheduler)

        presenter.locationSubject.onNext(nil)

        XCTAssertEqual(try title.toBlocking().first(),nil)

    }

    func testFirstPresenter_04() {
        let locationObserver = presenter.locationObservable.subscribeOn(scheduler)
        guard let latitude = CLLocationDegrees(exactly: 10.1),
            let longitude = CLLocationDegrees(exactly: 10.2) else { return }

        let location = CLLocation(latitude: latitude, longitude: longitude)

        presenter.locationSubject.onNext(location)

        XCTAssertEqual(try locationObserver.toBlocking().first(), location)

    }

    func testFirstPresenter_05() {
        let pointsObserver = presenter.pointsObservable.subscribeOn(scheduler)

        let empty: [PointElement] = []
        presenter.pointsSubject.onNext(empty)

        XCTAssertEqual(try pointsObserver.toBlocking().first(), empty)

    }

}
