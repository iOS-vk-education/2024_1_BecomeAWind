import SwiftUI

private enum FeedViewSizesPack {
    static let headerTitleFontSize: CGFloat = 30
}

struct FeedView: View {

    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        /// events list
        List {
            ForEach(viewModel.db.allEvents, id: \.self) { event in
                YEventCard(
                    viewModel: viewModel,
                    cardType: .feedEvent,
                    event: event
                )
                .listRowSeparator(.hidden)
            }

            Rectangle()
                .frame(height: EntryConst.tabBarHeight)
                .foregroundColor(Colors.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }

}

#Preview {
    FeedView()
}
