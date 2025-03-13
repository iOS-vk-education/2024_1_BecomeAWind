import SwiftUI
import _MapKit_SwiftUI

struct DisabledLocationServicesView: View {

    @ObservedObject var locationManager: LocationServicesStatusManager

    var body: some View {
        ZStack {
            Map(interactionModes: [])
            Colors.black
                .opacity(0.5)
                .ignoresSafeArea()

                VStack {
                    Text("службы геолокации выключены.\nвключи их в настройках.")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Colors.white)
                        .padding()

                    Button {
                        if let appSettings = URL(
                            string: UIApplication.openSettingsURLString
                        ) {
                            UIApplication.shared.open(appSettings)
                        }
                    } label: {
                        YCapsuleLabel(
                            title: "открыть настройки",
                            font: Const.buttonFont
                        )
                    }
                    .padding(.bottom)
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(Const.cornerRadius)
                .opacity(
                    locationManager.authStatus == .restricted
                    ? 1
                    : 0
                )
        }
    }

}

#Preview {
    DisabledLocationServicesView(
        locationManager: LocationServicesStatusManager()
    )
}
