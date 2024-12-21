import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var locationManager = LocationManager()
    @State private var profileActive = false
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        if locationManager.isLocationServicesEnabled {
            Map(position: $position) {
                UserAnnotation()
            }
            .tint(Color.purple)
            .mapControls {
                MapUserLocationButton()
            }
        } else {
            DisabledLocationServicesView()
        }
    }
}

struct DisabledLocationServicesView: View {
    var body: some View {
        ZStack {
            Map(interactionModes: [])
            Colors.black
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("YOUR LOCATION IS DISABLED\nPLEASE, ENABLE IT IN THE SETTIGNS")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Colors.white)
                }
                .padding()

                Button {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                } label: {
                    IndigoPurpleButtonLabel(title: "OPEN SETTINGS")
                }
                .padding(.bottom)
            }
            .padding()
            .background(Colors.black)
            .cornerRadius(Sizes.coreCornerRadius)
        }

    }
}

#Preview {
    DisabledLocationServicesView()
}
