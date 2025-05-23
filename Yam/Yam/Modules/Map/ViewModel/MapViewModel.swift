import SwiftUI
import MapKit

final class MapViewModel: ObservableObject {

    @ObservedObject var tempDatabase = TempDatabase.shared
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isActiveDetailedInfoView = false
    @State private var selectedEvent: Event?

}
