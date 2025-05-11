import SwiftUI

struct EventsView: View {

    @ObservedObject var viewModel: EventsViewModel

    var body: some View {
        ZStack {
            switch viewModel.activeTab {
            case .myEvents:
                viewModel.makeMyEventsView()
            case .feed:
                viewModel.makeFeedView()
            case .subscriptions:
                viewModel.makeSubscriptionsView()
            }

            EventsTabBar(viewModel: viewModel)
        }
        .edgesIgnoringSafeArea(.bottom)
    }

}
