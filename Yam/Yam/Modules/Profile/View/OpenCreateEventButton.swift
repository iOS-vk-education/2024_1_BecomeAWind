import SwiftUI

struct OpenCreateEventButton: View {

    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        HStack {
            Spacer()
            Button {
                viewModel.toggleCreateEvent()
            } label: {
                GradientImage(
                    imageName: "plus",
                    imageSize: ProfileConst.openCreateEventButtonSize,
                    cornerRadius: ProfileConst.openCreateEventButtonCornerRadius,
                    background: Gradients.purpleIndigo
                )
            }
            .padding(
                .trailing,
                ProfileConst.openCreateEventButtonSideSpace
            )
        }
    }

}

#Preview {
    @Previewable @StateObject var vm = ProfileViewModel()
    OpenCreateEventButton(viewModel: vm)
}
