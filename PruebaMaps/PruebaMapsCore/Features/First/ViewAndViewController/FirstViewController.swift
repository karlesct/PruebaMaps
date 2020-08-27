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
    func setUserLocation(location: CLLocationCoordinate2D?) {

        guard let location = location else { return }

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        mapView.camera = GMSCameraPosition(target: location,
                                           zoom: 15,
                                           bearing: .zero,
                                           viewingAngle: .zero)
    }

    func setLoading(_ loading: Bool) {

    }

}
