import SwiftUI
import MapKit

final class EventLocationViewModel: ObservableObject {

    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var placeDescription: String = "возникла ошибка при определении места ивента"

    @Published var event: Event

    init(event: Event) {
        self.event = event
        setupPlaceDescription()
    }

}

extension EventLocationViewModel {

    func centerMapOnEvent() {
        let coordinate = event.location.coordinate
        withAnimation(.easeInOut(duration: 0.5)) {
            position = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            )
        }
    }

    func setupPlaceDescription() {
        LocationHandler.getPlacemark(from: event.location) { [weak self] placemark in
            if let placemark {
                let description = LocationHandler.parsePlacemark(placemark)

                DispatchQueue.main.async {
                    self?.placeDescription = description
                }
            }
        }
    }

}
