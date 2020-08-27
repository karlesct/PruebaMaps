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

    func initLocation()
}

public class LocationService: NSObject, LocationServiceProtocol {

    // MARK: - Fields

    public weak var delegate: LocationServiceDelegate?

    private let dialogService: DialogServiceProtocol?
    private let locationManager = CLLocationManager()

    // MARK: Init

    public init(dialogService: DialogServiceProtocol) {

        self.dialogService = dialogService

    }

    // MARK: - Accessible Methods

    public func initLocation() {

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
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    private func requestAuthorization() {
        dialogService?.showAlert(title: "",
                                 message: "change_location_settings",
                                 btAcceptText: "open_settings",
                                 btCancelText: "cancel",
                                 btAcceptCompletion: {
                                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    }
        })
    }
}

extension LocationService: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        guard status == .authorizedWhenInUse else {
            return
        }

        delegate?.userLocation(manager: manager)

    }

}
