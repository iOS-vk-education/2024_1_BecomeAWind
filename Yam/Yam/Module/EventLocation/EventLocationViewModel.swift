import SwiftUI
import MapKit

final class EventLocationViewModel: ObservableObject {

    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var placeDescription: String
    @Published var event: Event

    init(event: Event) {
        self.event = event
        placeDescription = event.place.description
    }
    
}

extension EventLocationViewModel {

    func centerMapOnUserLocation() {
        withAnimation {
            position = .userLocation(fallback: .automatic)
        }
    }

    func centerMapOnEvent() {
        withAnimation(.easeInOut(duration: 0.5)) {
            position = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: event.place.geopoint.latitude,
                    longitude: event.place.geopoint.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            )
        }
    }

}
