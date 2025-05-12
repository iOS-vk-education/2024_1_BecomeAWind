import SwiftUI

struct FeedBottom: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        VStack {
            YTextField(text: $viewModel.searchString,
                       prompt: "введи название ивента",
                       lineLimit: 1,
                       axis: .horizontal)


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
