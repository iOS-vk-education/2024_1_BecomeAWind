import SwiftUI

struct DeleteEventButton: View {

    @ObservedObject var viewModel: BuildEventViewModel
    let action: () -> Void

    var body: some View {
        Button {
            viewModel.showSavingAlert()
        } label: {
            if viewModel.isDeletingEventLoaderFlag {
                GradientLoader(background: Gradient.blackPink, size: 50)
            } else {
                UnlimitedText(
                    text: viewModel.deleteEventButtonText,
                    font: Const.buttonFont,
                    background: Gradient.blackPink
                )
            }
        }
    }

}

