import UIKit

struct UIEvent: Identifiable, Hashable {
    let id = UUID()

    var image: UIImage
    var title: String
    var seats: Seats
    var link: String
    var date: Date
    var place: Place
}
