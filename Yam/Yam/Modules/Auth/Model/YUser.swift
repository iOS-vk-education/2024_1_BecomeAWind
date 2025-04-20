import Foundation

struct YUser: Identifiable {

    var id: String = UUID().uuidString
    let email: String
    let myEvents: [Event]
    let subscriptions: [Event]

    var representation: [String: Any] {
        var res = [String: Any]()

        res["id"] = id
        res["email"] = email
        res["myEvents"] = myEvents.map { $0.representation }
        res["subscriptions"] = subscriptions.map { $0.representation }

        return res
    }

}
