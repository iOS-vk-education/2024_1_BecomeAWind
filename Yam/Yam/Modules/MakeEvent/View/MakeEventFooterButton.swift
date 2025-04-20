import SwiftUI

struct MakeEventFooterButton: View {

    @ObservedObject var viewModel: MakeEventViewModel
    let action: () -> Void

    var body: some View {
        Button {
            if viewModel.handleEvent() {
                action()
            } else {
                viewModel.toggleEventHandlingFailed()
            }
        } label: {
            CapsuleLabel(
                title: viewModel.footerButtonText,
                font: Const.buttonFont
            )
        }
    }

}

#Preview {
    MakeEventFooterButton(viewModel: MakeEventViewModel(), action: {})
}
