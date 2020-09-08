//
//  LocationService.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit
import CoreLocation

public protocol LocationServiceDelegate: class {

    func userLocation(manager: CLLocationManager)

}

public protocol LocationServiceProtocol {

    var delegate: LocationServiceDelegate? { get set }

}

public class LocationService: NSObject, LocationServiceProtocol {

    // MARK: - Fields

    public weak var delegate: LocationServiceDelegate? {
        didSet {
            initLocation()
        }
    }

    private let locationManager = CLLocationManager()

    private func initLocation() {

        locationManager.delegate = self

        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }

    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied:
            requestAuthorization()
        case .notDetermined:
            // For use when the app is open & in the background
            //locationManager.requestAlwaysAuthorization()

            // For use when the app is open
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }

    private func startTrackingUserLocation() {

        //it starts the didUpdateLocations function in delegate
        locationManager.startUpdatingLocation()
    }

    private func requestAuthorization() {

        UIAlertController.Builder()
            .withTitle("warning".localized)
            .withMessage("change_location_settings".localized)
            .addActionWithTitle("open_settings".localized, handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            .addActionWithTitle("cancel".localized)
            .show()
    }
}

extension LocationService: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied,
             .notDetermined, .restricted:
            locationManager.stopUpdatingLocation()
        default:
            return
        }

    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let status = CLLocationManager.authorizationStatus()

        guard status == .authorizedAlways || status == .authorizedWhenInUse,
            locations.first != nil else {
            return
        }

        delegate?.userLocation(manager: manager)

    }

}
