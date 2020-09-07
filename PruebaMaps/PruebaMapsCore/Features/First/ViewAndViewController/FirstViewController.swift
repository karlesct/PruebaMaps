//
//  FirstViewController.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift

internal final class FirstViewController: UIViewController {

    // MARK: - IBoutlets

    @IBOutlet weak var mapView: GMSMapView!

    // MARK: - Properties

    private let presenter: FirstPresenterProtocol
    private var disposeBag: DisposeBag?

    // MARK: - Init

    init(presenter: FirstPresenterProtocol) {
        self.presenter = presenter

        self.disposeBag = DisposeBag()

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))

        self.setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.disposeBag = nil
    }

    // MARK: - Private methods

    private func setupBindings() {

        guard let disposeBag = disposeBag else { return }

        // ViewDidLoad
        self.rx.viewDidLoad
            .subscribe(onNext: {
                self.presenter.viewDidLoad()
            })
            .disposed(by: disposeBag)

        // ViewDidAppear
        self.rx.viewDidAppear
            .subscribe({ _ in
                self.presenter.viewDidAppear()
            })
            .disposed(by: disposeBag)

        // Points
        presenter.titlePageObservable
            .subscribe(onNext: { [weak self] titlePage in
                guard let strongSelf = self else { return }
                strongSelf.title = titlePage
            })
            .disposed(by: disposeBag)

        // Points
        presenter.pointsObservable
            .subscribe(onNext: { [weak self] points in
                guard let strongSelf = self else { return }
                strongSelf.update(with: points)
            })
            .disposed(by: disposeBag)

        // Location
        presenter.locationObservable
            .subscribe(onNext: { [weak self] location in
                guard let strongSelf = self else { return }
                strongSelf.setUserLocation(location: location)
            })
            .disposed(by: disposeBag)
    }

}

extension FirstViewController {

    func update(with points: Points) {

        points.forEach { item in

            item.marker.map = mapView
            item.marker.tracksViewChanges = false // Stop tracking view changes to allow CPU to idle.
        }
    }

    func setUserLocation(location: CLLocation?) {

        guard let location = location else { return }

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        mapView.camera = GMSCameraPosition(target: location.coordinate,
                                           zoom: 15,
                                           bearing: .zero,
                                           viewingAngle: .zero)

        let lowerLeftPoint = CGPoint(x: .zero, y: view.frame.origin.y + mapView.frame.height)
        let lowerLeft = mapView.projection.coordinate(for: lowerLeftPoint)
        print(lowerLeft)

        let upperRightPoint = CGPoint(x: view.frame.origin.x + mapView.frame.width, y: .zero)
        let upperRight = mapView.projection.coordinate(for: upperRightPoint)
        print(upperRight)

        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in

            guard let locality = placemarks?.first?.locality?.lowercased() else { return }

            self.presenter.fetchPoints(zone: locality, loweLeft: lowerLeft, upperRight: upperRight)
        })

    }
}
