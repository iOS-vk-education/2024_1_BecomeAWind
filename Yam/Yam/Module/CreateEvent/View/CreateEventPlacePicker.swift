import SwiftUI

struct CreateEventPlacePicker: View {
    @ObservedObject var viewModel: CreateEventViewModel
    @State private var isActiveChooseEventPlaceView = false

    var body: some View {
        YamWhiteText(text: "место \(Emoji.purpleCircle)")

        CreateEventVStack {
            YamWhiteText(
                text: viewModel.placeDescription,
                fontWeight: .regular,
                fontSize: CreateEventSizePack.placeDescriptionFontSize
            )
            .padding()

            Button {
                isActiveChooseEventPlaceView.toggle()
            } label: {
                YamMappin()
            }
            .padding(.bottom)
        }
        .fullScreenCover(isPresented: $isActiveChooseEventPlaceView) {
            ChooseEventPlaceView(
                viewModel: viewModel,
                isActiveChooseEventPlaceView: $isActiveChooseEventPlaceView)
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = CreateEventViewModel(model: CreateEventModel())
    CreateEventPlacePicker(viewModel: viewModel)
        .background(ColorPack.black)
}
