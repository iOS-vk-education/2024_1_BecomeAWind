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
            ) {
                ImageDownloader(path: viewModel.event.imagePath)
                    .scaledToFill()
                    .frame(width: EventLocationConst.imageSize, height: EventLocationConst.imageSize)
                    .clipped()
                    .cornerRadius(Const.cornerRadius)
            }
        }
        .tint(.purple)
        .colorScheme(.light)
    }

}

