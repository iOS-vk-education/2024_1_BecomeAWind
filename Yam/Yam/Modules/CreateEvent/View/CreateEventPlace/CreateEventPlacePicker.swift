import SwiftUI

struct CreateEventPlacePicker: View {
    @ObservedObject var viewModel: CreateEventViewModel
    @State private var isActiveCreateEventPlaceView = false

    var body: some View {
//        YamText("место \(Emoji.purpleCircle)")

        CreateEventVStack {
//            YamText(viewModel.placeDescription,
//                    fontWeight: .regular,
//                    fontSize: CreateEventSizePack.placeDescriptionFontSize
//            )
//            .padding(.horizontal)
//            .padding(.top)

            Button {
                isActiveCreateEventPlaceView.toggle()
            } label: {
                YamMappin()
            }
            .padding(.bottom)
        }
        .fullScreenCover(isPresented: $isActiveCreateEventPlaceView) {
            CreateEventPlaceView(
                viewModel: viewModel,
                isActiveCreateEventPlaceView: $isActiveCreateEventPlaceView)
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = CreateEventViewModel(model: CreateEventModel())
    CreateEventPlacePicker(viewModel: viewModel)
}
