import SwiftUI
import MapKit

struct EventLocationView: View {

    @ObservedObject var viewModel: EventLocationViewModel

    var body: some View {
        ZStack {
            EventLocationMap(viewModel: viewModel)

            VStack {
                EventLocationPlaceDescription(title: viewModel.placeDescription)

                Spacer()

                EventLocationBottomButtons {
                    viewModel.centerMapOnEvent()
                } showUser: {
                    viewModel.centerMapOnUserLocation()
                }
            }
            .padding(.vertical)
        }
    }

}

#Preview {
    EventLocationView(viewModel: EventLocationViewModel(event: Const.defaultEvent))
}

