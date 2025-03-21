import SwiftUI
import MapKit

struct EventLocationView: View {

    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EventLocationViewModel

    var body: some View {
        ZStack {
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

            /// dismiss
            YCircleButton(
                imageName: "xmark",
                background: Gradient.pinkIndigo
            ) {
                dismiss()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topTrailing
            )
            .padding([.trailing, .top], Const.sideSpace)

            VStack {
                YCapsuleLabel(
                    title: viewModel.placeDescription,
                    font: Const.placeDescriptionFont,
                    background: .thinMaterial
                )
                .frame(maxWidth: UIScreen.main.bounds.width / 2)

                Spacer()

                HStack {
                    Button {
                        viewModel.centerMapOnEvent()
                    } label: {
                        YCapsuleLabel(
                            title: "показать ивент",
                            font: Const.buttonFont
                        )
                    }

                    YCircleButton(imageName: "location") {
                        viewModel.centerMapOnUserLocation()
                    }
                }
            }
            .padding(.vertical, Const.sideSpace)
        }

    }

}

#Preview {
    EventLocationView(viewModel: EventLocationViewModel(event: Event(
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
