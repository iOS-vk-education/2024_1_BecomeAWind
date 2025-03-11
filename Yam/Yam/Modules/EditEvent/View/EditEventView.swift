import SwiftUI
import CoreLocation

struct EditEventView: View {

    @ObservedObject var viewModel: EditEventViewModel

    var body: some View {
        ZStack {
            Image(uiImage: viewModel.event.image)
                .resizable()
                .scaledToFill()
        }
        .frame(
            maxWidth: EditEventConst.imageWidth,
            maxHeight: EditEventConst.imageHeight
        )

    }
}

#Preview {
    EditEventView(viewModel: EditEventViewModel(event: Event(
        image: UIImage(named: "football")!,
        title: "event",
        seats: Seats(busy: 0, all: 100),
        link: "www",
        date: Date(),
        location: CLLocation()
            )
        )
    )
}
