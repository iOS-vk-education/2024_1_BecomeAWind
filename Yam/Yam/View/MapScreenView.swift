import SwiftUI
import MapKit

struct MapScreenView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {
        if locationManager.isLocationServicesEnabled {
            if let userLocation = locationManager.userLocation {
                MapView(locationManager: locationManager, userLocation: userLocation)
                    .ignoresSafeArea()
            } else {
                ProgressView("Определение геолокации...")
            }
        } else {
            DisabledLocationServicesView()
        }
    }

}

struct MapView: View {
    @ObservedObject var locationManager: LocationManager
    @State private var mapRegion: MKCoordinateRegion
    @State private var profileActive = false
    var userLocation: CLLocation

    init(locationManager: LocationManager, userLocation: CLLocation) {
        self.locationManager = locationManager
        _mapRegion = State(initialValue: MKCoordinateRegion(
            center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
        self.userLocation = userLocation
    }

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion,
                showsUserLocation: true)
            .ignoresSafeArea()

            // Buttons
            VStack {
                // Top buttons
                HStack {
                    // Profile button
                    VStack {
                        Button {
                            profileActive.toggle()
                        } label: {
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                        }
                        .sheet(isPresented: $profileActive) {
                            ProfileView()
                        }
                    }
                    .padding(10)
                    .background(.black)
                    .clipShape(Circle())

                    Spacer()

                    // Center on user location button
                    VStack {
                        Button {
                            centerOnUserLocation()
                        } label: {
                            Image(systemName: "location.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                        }
                    }
                    .padding(10)
                    .background(.black)
                    .clipShape(Circle())
                }
                .padding()

                Spacer()
            }
        }
    }

    private func centerOnUserLocation() {
        if let userLocation = locationManager.userLocation {
            mapRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MapDetails.span
            )
        }
    }
}

struct DisabledLocationServicesView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Определение твоей геолокации отключено.\nПожалуйста, включи его в настройках.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(.purple)
            .cornerRadius(20)
            .foregroundStyle(.white)

            Button {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            } label: {
                Text("Перейти в настройки")
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(20)
            }
        }
        .padding()
    }
}

#Preview {
    MapScreenView()
}
