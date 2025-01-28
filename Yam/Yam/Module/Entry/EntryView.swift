import SwiftUI
import MapKit

struct EntryView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {
       ZStack {
            if locationManager.isLocationServicesEnabled {
                MapView()

                // TabBar
                VStack {
                    Spacer()
                    TabBarView()
                }
            } else {
                DisabledLocationServicesView()
            }

      }
    }
}

struct DisabledLocationServicesView: View {
    var body: some View {
        ZStack {
            Map(interactionModes: [])
            ColorPack.black
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Службы геолокации выключены.\nВключите их в настройках.")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(ColorPack.white)
                }
                .padding()

                Button {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                } label: {
                    YamCapsuleLabel(title: "Открыть настройки", background: GradientPack.purpleIndigo)
                }
                .padding(.bottom)
            }
            .padding()
            .background(ColorPack.black)
            .cornerRadius(SizePack.coreCornerRadius)
        }

    }
}

// #Preview {
//    MainView()
// }
//
//
