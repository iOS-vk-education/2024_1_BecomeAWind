import FirebaseFirestore

struct Place: Hashable, Codable {
    var geopoint: GeoPoint
    var description: String

    var representation: [String: Any] {
        var res = [String: Any]()

        res["geopoint"] = geopoint
        res["description"] = description

        return res
    }
}
