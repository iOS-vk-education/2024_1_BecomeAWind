import SwiftUI

struct CreateEventPlacePicker: View {
    @ObservedObject var viewModel: CreateEventViewModel

    var body: some View {
        YText("место", font: CreateEventFont.sectionTitleFont)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, Const.sideSpace)

        CreateEventVStack {
            YText(
                viewModel.getPlaceDescription(),
                font: CreateEventFont.sectionContentFont
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
    @Previewable @StateObject var viewModel = CreateEventViewModel(model: CreateEventModel())
    CreateEventPlacePicker(viewModel: viewModel)
}
