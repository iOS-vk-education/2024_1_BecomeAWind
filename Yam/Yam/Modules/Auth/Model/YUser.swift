import Foundation

struct YUser: Identifiable, Codable {

    var id: String = UUID().uuidString
    var email: String

    var myEvents: [Event]
    var subscriptions: [Event]

    var representation: [String: Any] {
        var res = [String: Any]()

        res["id"] = id
        res["email"] = email

        return res
    }

}
