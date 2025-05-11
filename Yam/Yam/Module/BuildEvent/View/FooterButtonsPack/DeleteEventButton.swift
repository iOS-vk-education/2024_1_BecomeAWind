import SwiftUI

struct DeleteEventButton: View {

    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        Button {
            viewModel.showSavingAlert()
        } label: {
            if viewModel.isDeletingEventLoaderFlag {
                ProgressView()
                    .fixedSizeView(background: Gradient.blackPink)
            } else {
                Text(viewModel.deleteEventButtonText)
                    .fixedSizeText(background: Gradient.blackPink)
            }
        }
    }

}

