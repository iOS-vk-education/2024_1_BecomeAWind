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
                latitude: viewModel.event.place.latitude,
                longitude: viewModel.event.place.longitude)
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
//
//#Preview {
//    EventLocationMap(viewModel: EventLocationViewModel(event: UIEvent(
//        image: UIImage(named: "football")!,
//        title: "event",
//        seats: Seats(busy: 0, all: 100),
//        link: "www",
//        date: Date(),
//        place: Place(
//            location: CLLocation(),
//            placeDescription: "placedesc")
//    )
//    )
//    )
//}
