import Foundation
import UIKit

// enum EventCategory: String {
//    case sport = "Спортивные игры"
//    case entertainments = "Развлечения"
// }

struct Event: Identifiable {
    var id = UUID()

    var description: EventDescription
    var organization: EventOrganizationInformation
}

struct EventDescription {
    var title: String
    var description: String
    var image: UIImage
//    var category: EventCategory
}

struct EventOrganizationInformation {
    var date: DateModel
    var place: String
    var seats: Int
    var link: String
}
