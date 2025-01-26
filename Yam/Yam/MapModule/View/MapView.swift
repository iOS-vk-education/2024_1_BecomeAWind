import SwiftUI
import MapKit

struct MapView: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var isActiveDetailedInfoView = false 
    @ObservedObject var temp = TempDatabase.shared

    var body: some View {
        Map(position: $position) {
            UserAnnotation()

            Annotation("6", coordinate: temp.location1.coordinate) {
                Button {
                    isActiveDetailedInfoView.toggle()
                } label: {
                    YamCapsuleLabel(title: "6",
                                  fontSize: 30,
                                  background: GradientsPack.indigoPurple)
                }
                .sheet(isPresented: $isActiveDetailedInfoView) {
                    EntryEvent()
                }
            }
//            Annotation("10", coordinate: temp.location2.coordinate) {
//                Button {
//                    isActiveDetailedInfoView.toggle()
//                } label: {
//                    YamCapsuleLabel(title: "10",
//                                  fontSize: 30,
//                                  background: GradientsPack.indigoPurple)
//                }
//                .sheet(isPresented: $isActiveDetailedInfoView) {
//                    EntryEvent()
//                }
//            }
//            Annotation("1", coordinate: temp.location3.coordinate) {
//                Button {
//                    isActiveDetailedInfoView.toggle()
//                } label: {
//                    YamCapsuleLabel(title: "1",
//                                  fontSize: 30,
//                                  background: GradientsPack.indigoPurple)
//                }
//                .sheet(isPresented: $isActiveDetailedInfoView) {
//                    EntryEvent()
//                }
//            }
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
