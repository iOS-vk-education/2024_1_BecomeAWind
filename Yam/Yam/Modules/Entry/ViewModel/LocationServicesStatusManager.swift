import SwiftUI
import CoreLocation

final class LocationServicesStatusManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    enum LocationAuthStatus {
        case notDetermined
        case access
        case restricted
    }

    private let locationManager = CLLocationManager()
    @Published var isLocationServicesEnabled = false
    @Published var authStatus: LocationAuthStatus = .notDetermined

    override init() {
        super.init()
        initLocationManager()
    }

    private func initLocationManager() {
        locationManager.delegate = self
    }

    /*  Функция locationManagerDidChangeAuthorization(_ manager: CLLocationManager) принадлежит делегату CLLocationManagerDelegate. Она вызывается каждый раз когда создается объект класса CLLocationManager и когда меняется статус авторизации служб геолокации.
     https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/locationmanagerdidchangeauthorization(_:)
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }

    private func checkLocationAuthorizationStatus() {
        authStatus = .notDetermined

        switch locationManager.authorizationStatus {
        case .notDetermined:
            authStatus = .notDetermined
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            authStatus = .access
            isLocationServicesEnabled = true
        case .restricted, .denied:
            authStatus = .restricted
            isLocationServicesEnabled = false
        @unknown default:
            authStatus = .restricted
            isLocationServicesEnabled = false
        }
    }

}
