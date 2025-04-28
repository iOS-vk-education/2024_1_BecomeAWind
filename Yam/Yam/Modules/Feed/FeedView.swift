import SwiftUI

struct FeedView: View {

    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        /// events list
        List {
            ForEach(viewModel.allEvents, id: \.self) { event in
                EventCard(
                    viewModel: viewModel,
                    eventType: .notMy,
                    event: event
                )
                .listRowSeparator(.hidden)
            }

            Rectangle()
                .frame(height: AuthorizedEntryConst.tabBarHeight)
                .foregroundColor(.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }

}

#Preview {
    FeedView(viewModel: FeedViewModel())
}
