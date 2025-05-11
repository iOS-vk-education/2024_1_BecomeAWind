import ClusterMap
import CoreLocation

struct MapAnnotation: CoordinateIdentifiable, Identifiable, Hashable {
    let id = UUID()
    let event: Event
    var coordinate: CLLocationCoordinate2D
}
