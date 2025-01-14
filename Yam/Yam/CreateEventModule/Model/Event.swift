import Foundation

struct Event: Identifiable/*, Codable*/ {
    enum Category: String {
        case sport = "Спорт"
        case entertainment = "Развлечения"
        case other = "Другое"
    }

    let id = UUID()
    let title: String
    let description: String
//    let image: String
//    let category: Category
    let place: String
    let seats: Int
    let contact: String
}
