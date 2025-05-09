import Foundation
import CoreLocation

struct MapCluster: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
    let eventPack: [Event]
}
