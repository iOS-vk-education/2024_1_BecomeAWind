import FirebaseFirestore

struct Place: Hashable, Codable {
    var geopoint: GeoPoint
    var geohash: String
    var description: String

    var representation: [String: Any] {
        var res = [String: Any]()

        res["geopoint"] = geopoint
        res["geohash"] = geohash
        res["description"] = description

        return res
    }
}
