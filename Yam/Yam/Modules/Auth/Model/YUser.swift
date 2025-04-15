import Foundation

struct YUser: Identifiable {

    var id: String = UUID().uuidString
    var email: String

    var representation: [String: Any] {
        var res = [String: Any]()

        res["id"] = id
        res["email"] = email

        return res
    }

}
