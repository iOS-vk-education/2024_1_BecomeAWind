import SwiftUI
import MapKit

struct DisabledLocationServicesView: View {

    @ObservedObject var viewModel: EntryViewModel

    var body: some View {
        ZStack {
            Map(interactionModes: [])
                Color.black
                .opacity(0.5)
                .ignoresSafeArea()

            configureOpenSettingsView()
        }
    }

    private func configureOpenSettingsView() -> some View {
        ThinMaterialVStack {
            Text("службы геолокации выключены.\nвключи их в настройках.")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()

            Button {
                viewModel.openSettings()
            } label: {
                YCapsuleLabel(
                    title: "открыть настройки",
                    font: Const.buttonFont
                )
            }
            .padding(.bottom)
        }
        .opacity(viewModel.opacityOfOpenSettingsView)
    }

}

