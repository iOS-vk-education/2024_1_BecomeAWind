import UIKit

struct Event: Identifiable, Hashable {
    var id = UUID()

    var image: UIImage
    var title: String
    var seats: Seats
    var link: String
    var date: Date
    var place: Place
//    var location: CLLocation
}
