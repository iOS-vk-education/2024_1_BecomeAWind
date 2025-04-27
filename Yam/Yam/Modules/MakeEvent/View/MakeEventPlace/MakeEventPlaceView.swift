import SwiftUI
import MapKit

struct MakeEventPlaceView: View {

    @ObservedObject var viewModel: MakeEventViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                /// map
                MakeEventPlaceMap(viewModel: viewModel)
                    .ignoresSafeArea()
                    .colorScheme(.light)

                /// choose button
                Button {
                    viewModel.updatePlaceDescription { placemarkReceived in
                        if placemarkReceived {
                            dismiss()
                        } // else { alert }
                    }
                } label: {
                    YCapsuleLabel(
                        title: "Выбрать",
                        font: Const.buttonFont
                    )
                }
            }

            YCircleButton(imageName: "location") {}
        }
    }

}

 #Preview {
     MakeEventPlaceView(viewModel: MakeEventViewModel())
 }
