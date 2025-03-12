import SwiftUI

struct MakeEventPlacePicker: View {
    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        YText("место", font: MakeEventConst.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Const.sideSpace)

        MakeEventVStack {
            YText(
                viewModel.placeDescription,
                font: MakeEventConst.sectionContentFont
            )
            .padding(.horizontal)
            .padding(.top)

            YCircleButton(imageName: "location") {
                viewModel.toggleMakeEventPlace()
            }
            .padding(.bottom)
        }
        .fullScreenCover(
            isPresented: $viewModel.isActiveMakeEventPlace
        ) {
            MakeEventPlaceView(viewModel: viewModel)
        }
    }
}

#Preview {
    MakeEventPlacePicker(
        viewModel: MakeEventViewModel()
    )
}
