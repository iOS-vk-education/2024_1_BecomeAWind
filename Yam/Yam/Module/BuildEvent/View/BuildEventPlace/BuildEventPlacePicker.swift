import SwiftUI

struct BuildEventPlacePicker: View {
    @ObservedObject var viewModel: BuildEventViewModel

    var body: some View {
        YText("место", font: Const.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Const.sideSpace)

        BuildEventVStack {
            YText(
                viewModel.placeDescription,
                font: Const.sectionEmptyFont
            )
            .padding(.horizontal)
            .padding(.top)

            CircleButton(imageName: "location") {
                viewModel.toggleBuildEventPlace()
            }
            .padding(.bottom)
        }
        .fullScreenCover(
            isPresented: $viewModel.isActiveBuildEventPlace
        ) {
            BuildEventPlaceView(viewModel: viewModel)
        }
    }
}

#Preview {
    BuildEventPlacePicker(
        viewModel: BuildEventViewModel()
    )
}
