//
//  FirstViewController.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import GoogleMaps

internal final class FirstViewController: UIViewController {

    // MARK: - IBoutlets

    @IBOutlet weak var mapView: GMSMapView!

    // MARK: - Properties

    private let presenter: FirstPresenterProtocol

    // MARK: - Init

    init(presenter: FirstPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        presenter.view = self

        presenter.loadView()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.didAppearView()
    }

    // MARK: - Private methods

    private func setupUI() {

    }

    // MARK: - Actions

}

extension FirstViewController: FirstViewProtocol {
    func setUserLocation(location: CLLocation?) {

        guard let location = location else { return }

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        mapView.camera = GMSCameraPosition(target: location.coordinate,
                                           zoom: 15,
                                           bearing: .zero,
                                           viewingAngle: .zero)

        let lowerLeftPoint = CGPoint(x: mapView.frame.height, y: .zero)
        let lowerLeft = mapView.projection.coordinate(for: lowerLeftPoint)
        print(lowerLeft)

        let upperRightPoint = CGPoint(x: .zero, y: mapView.frame.width)
        let upperRight = mapView.projection.coordinate(for: upperRightPoint)
        print(upperRight)

        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in

            guard let locality = placemarks?.first?.locality?.lowercased() else { return }

            self.presenter.fetchPoints(zone: locality, loweLeft: lowerLeft, upperRight: upperRight)
        })

    }

    func setLoading(_ loading: Bool) {

    }

    func update(with points: Points) {

        points.forEach { item in

            item.marker.map = mapView
            item.marker.tracksViewChanges = false // Stop tracking view changes to allow CPU to idle.
        }
    }
}
