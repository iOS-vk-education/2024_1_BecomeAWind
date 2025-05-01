import SwiftUI
import FirebaseFirestore

enum EventsConst {

    /// event card
    static let capsuleLabelFont = FontManager.getFont(with: .medium, and: 13)
    static let sideSpace: CGFloat = 20
    static let defaultEvent: Event = Event(
        imagePath: "",
        title: "",
        seats: Seats(busy: 0, all: 1),
        link: "",
        date: Date(),
        place: Place(geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), description: "")
    )

}
