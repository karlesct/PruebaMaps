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

internal final class FirstViewController: BaseViewController<FirstPresenter> {

    // MARK: - IBoutlets

    @IBOutlet weak var mapView: GMSMapView!

    // MARK: - Properties

    // MARK: - Private methods

    override func setupBindings() {
        super.setupBindings()

        guard let disposeBag = self.disposeBag else { return }

        // Title
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
