import SwiftUI
import MapKit

struct EventLocationView: View {

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
                    YImage(image: event.image, size: EventLocationConst.imageSize)
                }
            }
            .tint(Color.purple)
            .mapControls {
                MapUserLocationButton()
            }

//            VStack {
////                YamCapsuleLabel(title: PlaceHandler.handlePlace(event.organization.place))
////                .frame(maxWidth: UIScreen.main.bounds.width / 2)
//
//                Spacer()
//                Button(action: centerMapOnEvent) {
////                    YamCapsuleLabel(title: "Показать мероприятие")
//                }
//
//            }
//            .padding(.top)
        }

    }

    private func centerMapOnEvent() {
        /*
        if let place = event.organization.place {
            withAnimation(.easeInOut(duration: 0.5)) {
                position = .region(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: place.coordinate.latitude,
                                                   longitude: place.coordinate.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                ))
            }
        }
         */
    }

}
//
// #Preview {
//    EventLocationView()
// }
