import SwiftUI
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var isLocationServicesEnabled = false

    override init() {
        super.init()
        initLocationManager()
    }

    private func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func checkLocationAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationServicesEnabled = true
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            isLocationServicesEnabled = false
        @unknown default:
            isLocationServicesEnabled = false
        }
    }

    /*  Функция locationManagerDidChangeAuthorization(_ manager: CLLocationManager) принадлежит делегату CLLocationManagerDelegate. Она вызывается каждый раз когда создается объект класса CLLocationManager и когда меняется статус авторизации служб геолокации.
     https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/locationmanagerdidchangeauthorization(_:)
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.checkLocationAuthorizationStatus()
    }
}

