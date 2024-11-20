import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var profileActive = false

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.currentLocation, showsUserLocation: true)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }

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

                    // Current location button
                    VStack {
                        Button {
                            viewModel.setCurrentLocation()
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

}

#Preview {
    MapView()
}
