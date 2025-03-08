import Foundation

struct UserModel: Identifiable {
    var id = UUID()

    var login: String
    var email: String
    var password: String
}
