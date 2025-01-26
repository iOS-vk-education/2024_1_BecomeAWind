import SwiftUI
import MapKit

struct EventLocationView: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var region: MKCoordinateRegion

    let event: Event

    init(event: Event) {
        self.event = event

        if let place = event.organization.place {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.coordinate.latitude,
                                                                       longitude: place.coordinate.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        } else {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Пример координат
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }

    }

    var body: some View {
        ZStack {
            Map(position: $position) {
                if let place = event.organization.place {
                    Annotation("", coordinate: place.coordinate) {
                        YamImage(image: event.description.image, size: 70)
                    }
                }

            }
            .tint(Color.purple)
            .mapControls {
                MapUserLocationButton()
            }

            VStack {
                YamCapsuleLabel(title: PlaceHandler.handlePlace(event.organization.place),
                                background: GradientsPack.orangePurple)
                Spacer()
                Button(action: centerMapOnEvent) {
                    YamCapsuleLabel(title: "Показать мероприятие", background: GradientsPack.purpleIndigo)
                }

            }
            .padding(.top)
        }

    }

    private func centerMapOnEvent() {
        if let place = event.organization.place {
            withAnimation(.easeInOut(duration: 0.5)) {
                position = .region(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: place.coordinate.latitude,
                                                   longitude: place.coordinate.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                ))
            }
        }
    }

}
//
//#Preview {
//    EventLocationView()
//}

