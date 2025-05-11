import SwiftUI
import MapKit

struct DisabledLocationServicesView: View {

    @ObservedObject var viewModel: AuthorizedEntryViewModel

    var body: some View {
        ZStack {
            Map(interactionModes: [])

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
                UnlimitedText(
                    text: "открыть настройки",
                    font: Const.buttonFont
                )
            }
            .padding(.bottom)
        }
        .opacity(viewModel.opacityOfOpenSettingsView)
    }

}

