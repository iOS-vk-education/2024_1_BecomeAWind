import SwiftUI
import MapKit

struct CreateEventPlaceView: View {

    @ObservedObject var viewModel: CreateEventViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                /// map
                CreateEventPlaceMap(viewModel: viewModel)
                    .ignoresSafeArea()
                    .colorScheme(.light)

                /// choose button
                Button {
                    viewModel.getPlacemark { placemarkReceived in
                        if placemarkReceived {
                            dismiss()
                        }
                    }
                } label: {
                    YCapsuleLabel(
                        title: "выбрать",
                        font: CreateEventFont.chooseButtonFont
                    )
                }
            }

            YCircleButton(imageName: "location") {}
        }
    }

}

 #Preview {
     CreateEventPlaceView(
        viewModel: CreateEventViewModel(model: CreateEventModel())
     )
 }
