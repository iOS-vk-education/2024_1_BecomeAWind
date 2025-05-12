import SwiftUI

struct MapBottomButtons: View {

    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        VStack {
            Spacer()

            EventsOnMapButton(viewModel: viewModel) {
                Task {
                    await viewModel.showEventsAccordion(eventPack: viewModel.mapEvents)
                }
            }

            HStack {
                OpenEventsButton {
                    viewModel.openEvents()
                }

                LocationButton {
                    viewModel.centerMapOnUserLocation()
                }

                OpenProfileButton {
                    viewModel.openProfile()
                }
            }
        }
        .padding(.bottom, 10)
    }
    
}

#Preview {
    MapBottomButtons(viewModel: MapViewModel(navManager: NavigationManager()))
}
