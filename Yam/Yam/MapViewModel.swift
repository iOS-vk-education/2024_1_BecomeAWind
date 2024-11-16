import MapKit
import SwiftUI

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 55.751188, longitude: 37.627939)
    static let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center:
            MapDetails.startingLocation,
        span:
            MapDetails.span
    )

    var locationManager: CLLocationManager?

    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager?.delegate = self
            } else {
                print("Show alert to enable location services")
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }

    func changeRegion() {
        guard let location = locationManager?.location else {
            return
        }

        withAnimation {
            region = MKCoordinateRegion(
                center: location.coordinate,
                span: MapDetails.span
            )
        }
    }

    private func checkLocationAuthorizationStatus() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted")
        case .denied:
            print("Your have denied location permission")
        case .authorizedAlways, .authorizedWhenInUse:
            changeRegion()
        @unknown default:
            break
        }
    }
}
