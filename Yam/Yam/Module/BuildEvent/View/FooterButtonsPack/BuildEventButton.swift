import SwiftUI

struct BuildEventButton: View {

    @ObservedObject var viewModel: BuildEventViewModel
    let action: () -> Void

    var body: some View {
        Button {
            Task {
                await viewModel.handleEvent() ? action() : viewModel.toggleEventHandlingFailed()
            }
        } label: {
            if viewModel.isBuildingEventLoaderFlag {
                ProgressView()
                    .fixedSizeView()
            } else {
                Text(viewModel.footerButtonText)
                    .fixedSizeText()
            }
        }
    }

}
