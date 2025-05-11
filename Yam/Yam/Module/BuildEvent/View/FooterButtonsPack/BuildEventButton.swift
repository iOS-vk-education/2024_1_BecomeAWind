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
            if viewModel.buildingInProgress {
                ProgressView()
                    .fixedSizeView()
            } else {
                Text(viewModel.footerButtonText)
                    .fixedSizeText()
            }
        }
        .disabled(viewModel.buildingInProgress)
    }

}
