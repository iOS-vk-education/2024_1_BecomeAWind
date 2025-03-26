import SwiftUI

struct FeedView: View {

    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        /// events list
        List {
            ForEach(viewModel.allEvents, id: \.self) { event in
                EventCard(
                    viewModel: viewModel,
                    cardType: .external,
                    event: event
                )
                .listRowSeparator(.hidden)
            }

            Rectangle()
                .frame(height: EntryConst.tabBarHeight)
                .foregroundColor(.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear { viewModel.updateFeed() }
    }

}

#Preview {
    FeedView()
}
