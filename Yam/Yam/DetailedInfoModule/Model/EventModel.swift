import Foundation

enum EventCategory: String {
    case sport = "Спортивные игры"
    case entertainments = "Развлечения"
}

struct Event2: Identifiable {
    var id = UUID()

    var description: EventDescription
    var organization: EventOrganizationInformation
}

struct EventDescription {
    var title: String
    var description: String
    var imageName: String
    var category: EventCategory
}

struct EventOrganizationInformation {
    var place: String
    var freePlaces: Int
    var link: String
}
