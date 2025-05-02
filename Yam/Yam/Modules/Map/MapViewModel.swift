import SwiftUI
import MapKit

final class MapViewModel: ObservableObject {

    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isActiveDetailedInfoView = false
    @State private var selectedEvent: UIEvent?

    @Published var mapEvents: [Event] = []

}

extension MapViewModel {

    func getEventsInRegion(_ region: MKCoordinateRegion) async {
        let center = region.center
        let span = region.span


    }

}
