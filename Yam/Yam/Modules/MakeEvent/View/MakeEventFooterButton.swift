import SwiftUI

struct MakeEventFooterButton: View {

    @ObservedObject var viewModel: MakeEventViewModel
    let action: () -> Void

    var body: some View {
        Button {
            Task {
                await viewModel.handleEvent() ? action() : viewModel.toggleEventHandlingFailed()
            }
        } label: {
            if viewModel.isCreatingEvent {
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
    MakeEventFooterButton(viewModel: MakeEventViewModel(), action: {})
}
