import SwiftUI
import MapKit

struct BuildEventPlaceView: View {

    @ObservedObject var viewModel: BuildEventViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                /// map
                BuildEventPlaceMap(viewModel: viewModel)
                    .ignoresSafeArea()
                    .colorScheme(.light)

                /// choose button
                Button {
                    Task {
                        if await viewModel.updatePlaceDescription() {
                            dismiss()
                        } // else { alert }
                    }
                } label: {
                    UnlimitedText(
                        text: "выбрать",
                        font: Const.buttonFont
                    )
                }
            }

            CircleButton(imageName: "location") {}
        }
    }

}

 #Preview {
     BuildEventPlaceView(viewModel: BuildEventViewModel())
 }
