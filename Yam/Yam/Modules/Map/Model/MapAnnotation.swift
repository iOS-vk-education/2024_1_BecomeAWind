import ClusterMap
import CoreLocation

struct MapAnnotation: CoordinateIdentifiable, Identifiable, Hashable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}
