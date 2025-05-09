import Foundation

struct YUser: Identifiable, Codable {

    var id: String
    var email: String
    var myEventsIDs: [String]
    var subscriptionsIDs: [String]

    var representation: [String: Any] {
        var res = [String: Any]()

        res["id"] = id
        res["email"] = email
        res["myEventsIDs"] = myEventsIDs
        res["subscriptionsIDs"] = subscriptionsIDs

        return res
    }

}
