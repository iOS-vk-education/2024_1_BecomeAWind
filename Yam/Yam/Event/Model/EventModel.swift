//
//  EventModel.swift
//  Yam
//
//  Created by Ширапов Арсалан on 01.01.2025.
//

import Foundation

enum EventCategory: String {
    case sport = "Спортивные игры"
    case entertainments = "Развлечения"
}

struct Event: Identifiable {
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
