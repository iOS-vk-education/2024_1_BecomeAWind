import SwiftUI
import MapKit

struct MainView: View {
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
            ColorsPack.black
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Службы геолокации выключены.\nВключите их в настройках.")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(ColorsPack.white)
                }
                .padding()

                Button {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                } label: {
                    GradientLabel(title: "Открыть настройки", background: GradientsPack.indigoPurple)
                }
                .padding(.bottom)
            }
            .padding()
            .background(ColorsPack.black)
            .cornerRadius(BaseSizesPack.coreCornerRadius)
        }

    }
}

//#Preview {
//    MainView()
//}
//
//


