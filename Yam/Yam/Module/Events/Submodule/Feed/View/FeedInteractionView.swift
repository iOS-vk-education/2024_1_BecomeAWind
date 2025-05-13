import SwiftUI

struct FeedInteractionView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        VStack {
            YTextField(text: $viewModel.searchString,
                       prompt: "введи название ивента",
                       lineLimit: 1,
                       axis: .horizontal)

            if viewModel.searchedFeedEvents.filter { !viewModel.dbService.myEventsIDs.contains($0.id) }.isEmpty {
                EmptyEventsView(text: "ивентов в ленте не найдено")
            }


            Spacer()

            HStack {
                EventsCountView(countString: viewModel.getFeedEventsCount())

                DismissButton {
                    dismiss()
                }
            }

            TabBarSpace()
        }
    }

}
