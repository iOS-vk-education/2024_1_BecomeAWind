import SwiftUI
import _MapKit_SwiftUI

struct MapView: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isActiveDetailedInfoView = false
    @State private var selectedEvent: Event?

    @ObservedObject var tempDatabase = TempDatabase.shared // delme

    var body: some View {
        /*
        Map(position: $position) {
            UserAnnotation()

            Annotation("", coordinate: tempDatabase.location1.coordinate) {
                Button {
                    isActiveDetailedInfoView.toggle()
                } label: {
//                    YamCapsuleLabel(title: "4",
//                                  fontSize: 30,
//                                  background: GradientPack.purpleIndigo)
                }
                .sheet(isPresented: $isActiveDetailedInfoView) {
                    DetailedInfoView(events: tempDatabase.events)
                }
            }

            ForEach(tempDatabase.events, id: \.id) { event in
                if let place = event.organization.place {
                    Annotation("", coordinate: place.coordinate) {
                        Button {
                            selectedEvent = event
                        } label: {
                            YamImage(image: event.description.image, size: 70)
                        }
                    }
                }
            }
        }
        .colorScheme(.light)
        .tint(Color.purple)
        .mapControls {
            MapUserLocationButton()
        }
        .sheet(item: $selectedEvent) { event in
            DetailedInfoView(events: [event])
        }
         */
        Text("map")
    }
}

#Preview {
    MapView()
}
