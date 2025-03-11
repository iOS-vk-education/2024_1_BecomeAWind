import SwiftUI

struct CreateEventPlacePicker: View {
    @ObservedObject var viewModel: CreateEventViewModel

    var body: some View {
        YText("место", font: CreateEventConst.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Const.sideSpace)

        CreateEventVStack {
            YText(
                viewModel.placeDescription,
                font: CreateEventConst.sectionContentFont
            )
            .padding(.horizontal)
            .padding(.top)

            YCircleButton(imageName: "location") {
                viewModel.toggleCreateEventPlace()
            }
            .padding(.bottom)
        }
        .fullScreenCover(
            isPresented: $viewModel.isActiveCreateEventPlace
        ) {
            CreateEventPlaceView(viewModel: viewModel)
        }
    }
}

#Preview {
    CreateEventPlacePicker(
        viewModel: CreateEventViewModel()
    )
}
