import SwiftUI
import MapKit

struct EventLocationMap: View {

    @ObservedObject var viewModel: EventLocationViewModel

    var body: some View {
        Map(position: $viewModel.position) {
            /// user location
            UserAnnotation()

            /// event location
            Annotation("", coordinate: CLLocationCoordinate2D(
                latitude: viewModel.event.place.location.coordinate.latitude,
                longitude: viewModel.event.place.location.coordinate.longitude)
            ) {
                YImage(
                    image: viewModel.event.image,
                    size: EventLocationConst.imageSize
                )
            }
        }
        .tint(.purple)
        .colorScheme(.light)
    }

}

#Preview {
    EventLocationMap(viewModel: EventLocationViewModel(event: Event(
        image: UIImage(named: "football")!,
        title: "event",
        seats: Seats(busy: 0, all: 100),
        link: "www",
        date: Date(),
        place: Place(
            location: CLLocation(),
            placeDescription: "placedesc")
    )
    )
    )
}
