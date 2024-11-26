import MapKit
import SwiftUI

struct MapDetails {
    static let startLatitudeLongitude = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    static let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

//    static let startPosition = MKCoordinateRegion(
//        center: MapDetails.startLatitudeLongitude,
//        span: MapDetails.span
//    )
}

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var userLocation: CLLocation?
    @Published var isLocationServicesEnabled = false

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorizationStatus()
        } else {
            isLocationServicesEnabled = false
        }
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


}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        withAnimation {
            userLocation = location
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
}
