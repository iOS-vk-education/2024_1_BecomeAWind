import UIKit
import MapKit

struct Event: Identifiable, Hashable {
    var id = UUID()

    var image: UIImage
    var title: String
    var seats: Int
    var link: String
    var date: Date
    var geopoint: CLLocation
}
