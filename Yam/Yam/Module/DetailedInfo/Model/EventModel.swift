import Foundation
import UIKit

struct Event: Identifiable {
    var id = UUID()

    var description: EventDescription
    var organization: EventOrganizationInformation
}

struct EventDescription {
    var title: String
    var description: String
    var image: UIImage
}

struct EventOrganizationInformation {
    var date: DateModel
    var place: PlaceModel?
    var seats: Int
    var link: String
}
