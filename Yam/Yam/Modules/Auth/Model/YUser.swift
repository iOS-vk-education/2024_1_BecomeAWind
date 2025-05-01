import Foundation

struct YUser: Identifiable, Codable {

    var id: String
    var email: String
    var myEventsIDs: [String]

    var representation: [String: Any] {
        var res = [String: Any]()

        res["id"] = id
        res["email"] = email
        res["myEventsIDs"] = myEventsIDs

        return res
    }

}
