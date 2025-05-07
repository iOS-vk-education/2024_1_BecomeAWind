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
                latitude: viewModel.event.place.geopoint.latitude,
                longitude: viewModel.event.place.geopoint.longitude)
            ) { EventOnMap(imagePath: viewModel.event.imagePath) }
        }
        .tint(.purple)
        .colorScheme(.light)
    }

}

