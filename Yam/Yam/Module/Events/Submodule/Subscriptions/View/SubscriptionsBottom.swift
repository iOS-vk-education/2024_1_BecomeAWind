import SwiftUI

struct SubscriptionsBottom: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SubscriptionsViewModel

    var body: some View {
        VStack {
            Spacer()


            HStack {
                EventsCountView(countString: viewModel.getSubscriptionsCount())

                DismissButton {
                    dismiss()
                }
            }

            TabBarSpace()
        }
    }
    
}

