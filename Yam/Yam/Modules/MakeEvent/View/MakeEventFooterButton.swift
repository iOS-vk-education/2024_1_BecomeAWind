import SwiftUI

struct MakeEventFooterButton: View {

    @ObservedObject var viewModel: MakeEventViewModel
    let action: () -> Void

    var body: some View {
        Button {
            Task {
                let eventCreated = await viewModel.handleEvent()

                if eventCreated {
                    action()
                } else {
                    viewModel.toggleEventHandlingFailed()
                }
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
