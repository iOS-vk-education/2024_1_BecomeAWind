import UIKit

struct Event: Identifiable {
    var id = UUID()

    var image: UIImage
    var title: String
    var seats: Int
    var link: String
    var date: Date
    var place: PlaceModel?
}
