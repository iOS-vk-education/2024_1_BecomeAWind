import SwiftUI
import MapKit

struct EventLocationView: View {

    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EventLocationViewModel

    var body: some View {
        ZStack {
            EventLocationMap(viewModel: viewModel)

            DismissButton { dismiss() }

            VStack {
                EventLocationPlaceDescription(title: viewModel.placeDescription)

                Spacer()

                EventLocationBottomButtons {
                    viewModel.centerMapOnEvent()
                } showUserAction: {
                    viewModel.centerMapOnUserLocation()
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
