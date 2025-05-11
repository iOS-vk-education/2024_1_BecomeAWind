import SwiftUI

struct MapSwitcherView: View {

    @ObservedObject var viewModel: MapViewModel

    var body: some View {
        if viewModel.isLocationServicesEnabled {
            MapView(viewModel: viewModel)
        } else {
            DisabledLocationServicesView(viewModel: viewModel)
        }
    }
}

#Preview {
    MapSwitcherView(viewModel: MapViewModel(navManager: NavigationManager()))
}
