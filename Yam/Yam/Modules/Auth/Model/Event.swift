import Foundation
import FirebaseFirestore

struct Event: Identifiable {
    let id = UUID().uuidString

    var imageUrl: String
    var title: String
    var seats: Seats
    var link: String
    var date: Date
    var place: GeoPoint

    var representation: [String: Any] {
        var res = [String: Any]()

        res["id"] = id
        res["imageUrl"] = imageUrl
        res["title"] = title
        res["seats"] = seats.representation
        res["link"] = link
        res["date"] = date
        res["place"] = place

        return res
    }
}
