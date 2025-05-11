import SwiftUI

struct AuthorizedEntryView: View {

    @ObservedObject var viewModel: AuthorizedEntryViewModel

    var body: some View {
        ZStack {
            if viewModel.isLocationServicesEnabled {
                switch viewModel.activeTab {
                case .events:
                    viewModel.makeEventsView()
                case .feed:
                    viewModel.makeFeedView()
                case .profile:
                    viewModel.makeProfileView()
                }

                EntryTabBar(viewModel: viewModel)
            } else {
                DisabledLocationServicesView(viewModel: viewModel)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

}
