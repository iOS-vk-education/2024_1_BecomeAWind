import SwiftUI

struct EntryView: View {

    @StateObject var viewModel = EntryViewModel()

    var body: some View {
        ZStack {
            if viewModel.isLocationServicesEnabled {
                switch viewModel.activeTab {
                case .events:
                    EventsView()
                case .search:
                    FeedView()
                case .map:
                    MapView()
                }

                EntryTabBar(viewModel: viewModel)
            } else {
                DisabledLocationServicesView(viewModel: viewModel)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

}
