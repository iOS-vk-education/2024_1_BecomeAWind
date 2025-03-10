import SwiftUI
import MapKit

struct EventLocationView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)

    let event: Event

    var body: some View {
        ZStack {
            Map(position: $position) {
                UserAnnotation()
                Annotation("", coordinate: CLLocationCoordinate2D(
                    latitude: event.geopoint.coordinate.latitude,
                    longitude: event.geopoint.coordinate.longitude)
                ) {
                    YImage(
                        image: event.image,
                        size: EventLocationConst.imageSize
                    )
                }
            }
            .tint(Colors.purple)
            .mapControls {
                MapUserLocationButton()
            }

            VStack {
                YCapsuleLabel(
                    title: "место добавить",
                    font: EventLocationConst.placeDescriptionFont,
                    background: .thinMaterial
                )
                .frame(maxWidth: UIScreen.main.bounds.width / 2)

                Spacer()

                HStack {
                    Button(action: centerMapOnEvent) {
                        YCapsuleLabel(
                            title: "показать место ивента",
                            font: Const.buttonFont
                        )
                    }

                    YCircleButton(imageName: "xmark") {
                        dismiss()
                    }
                }
            }
            .padding(.top)
        }

    }

}

extension EventLocationView {

    private func centerMapOnEvent() {
        let coordinate = event.geopoint.coordinate
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

}

#Preview {
    EventLocationView(event: Event(
        image: UIImage(named: "football")!,
        title: "event",
        seats: Seats(busy: 0, all: 100),
        link: "www",
        date: Date(),
        geopoint: CLLocation()
    )
    )
}
