import SwiftUI

struct AuthorizedEntryView: View {

    @ObservedObject var viewModel: AuthorizedEntryViewModel

    var body: some View {
        ZStack {
            if viewModel.isLocationServicesEnabled {
                switch viewModel.activeTab {
                case .events:
                    EventsView()
                case .feed:
                    FeedView()
                case .map:
                    MapView()
                case .profile:
                    ProfileView()
                }

                EntryTabBar(viewModel: viewModel)
            } else {
                DisabledLocationServicesView(viewModel: viewModel)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

}
