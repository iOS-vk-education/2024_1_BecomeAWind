import SwiftUI
import MapKit

struct MapView: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var isActiveDetailedInfoView = false
    @ObservedObject var tempDatabase = TempDatabase.shared

    var body: some View {
        Map(position: $position) {
            UserAnnotation()

            Annotation("", coordinate: tempDatabase.location1.coordinate) {
                Button {
                    isActiveDetailedInfoView.toggle()
                } label: {
                    YamCapsuleLabel(title: "3",
                                  fontSize: 30,
                                  background: GradientsPack.purpleIndigo)
                }
                .sheet(isPresented: $isActiveDetailedInfoView) {
                    DetailedInfoView(events: tempDatabase.events)
                }
            }
        }
        .tint(Color.purple)
        .mapControls {
            MapUserLocationButton()
        }
    }
}

#Preview {
    DisabledLocationServicesView()
}
