import Foundation
import FirebaseFirestore

struct Event: Identifiable {
    var id: String

//    var image: UIImage
    var title: String
    var seats: Seats
    var link: String
    var date: Date
    var place: GeoPoint

    var representation: [String: Any] {
        var res = [String: Any]()

        res["id"] = id
        res["title"] = title
        res["seats"] = seats.representation
        res["link"] = link
        res["date"] = date
        res["place"] = place

        return res
    }
}
