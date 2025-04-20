import SwiftUI

struct MakeEventPlacePicker: View {
    @ObservedObject var viewModel: MakeEventViewModel

    var body: some View {
        YText("место", font: Const.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Const.sideSpace)

        MakeEventVStack {
            YText(
                viewModel.placeDescription,
                font: Const.sectionEmptyFont
            )
            .padding(.horizontal)
            .padding(.top)

            CircleButton(imageName: "location") {
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
