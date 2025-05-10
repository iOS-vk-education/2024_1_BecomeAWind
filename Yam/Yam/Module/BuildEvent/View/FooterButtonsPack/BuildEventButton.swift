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
                GradientLoader(size: 50)
            } else {
                RectText(
                    text: viewModel.footerButtonText,
                    font: Const.buttonFont
                )
            }
        }
    }

}
