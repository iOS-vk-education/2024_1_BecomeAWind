import SwiftUI

struct DeleteEventButton: View {

    @ObservedObject var viewModel: BuildEventViewModel
    let action: () -> Void

    var body: some View {
        Button {
            viewModel.showSavingAlert()
        } label: {
            if viewModel.isDeletingEventLoaderFlag {
                GradientLoader(size: 50, background: Gradient.blackPink)
            } else {
                CapsuleLabel(
                    title: viewModel.deleteEventButtonText,
                    font: Const.buttonFont,
                    background: Gradient.blackPink
                )
            }
        }
    }

}

