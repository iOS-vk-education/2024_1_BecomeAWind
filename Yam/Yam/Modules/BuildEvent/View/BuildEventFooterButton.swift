import SwiftUI

struct BuildEventFooterButton: View {

    @ObservedObject var viewModel: BuildEventViewModel
    let action: () -> Void

    var body: some View {
        Button {
            Task {
                await viewModel.handleEvent() ? action() : viewModel.toggleEventHandlingFailed()
            }
        } label: {
            if viewModel.isCreatingEventLoaderFlag {
                YLoader(size: 50)
            } else {
                CapsuleLabel(
                    title: viewModel.footerButtonText,
                    font: Const.buttonFont
                )
            }
        }
    }

}

#Preview {
    BuildEventFooterButton(viewModel: BuildEventViewModel(), action: {})
}
