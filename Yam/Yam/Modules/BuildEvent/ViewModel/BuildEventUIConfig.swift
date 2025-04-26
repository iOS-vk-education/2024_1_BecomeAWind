import SwiftUI
import CoreLocation

struct BuildEventUIConfig {

    let type: BuildEventType
    var event: Event?

    var headerText: String {
        type == .create ? "новый ивент" : "редактирование ивента"
    }

    var imagePickerButtonText: String {
        type == .create ? "выбери превью" : "измени превью"
    }

    var eventTitle: String {
        type == .create ? "" : event?.title ?? ""
    }

    var allSeats: String {
        type == .create ? "1" : String(event?.seats.all ?? 1)
    }

    var link: String {
        type == .create ? "" : event?.link ?? ""
    }

    var date: Date {
        type == .create ? Date() : event?.date ?? Date()
    }

    var placeDescription: String {
        type == .create
        ? BuildEventConst.emptyPlaceText
        : event?.place.description ?? BuildEventConst.emptyPlaceText
    }

    var location: CLLocation? {
        guard let event else { return nil }

        let location = CLLocation(
            latitude: event.place.geopoint.latitude,
            longitude: event.place.geopoint.longitude
        )

        return type == .create ? nil : location
    }

    var footerButtonText: String {
        type == .create ? "создать ивент" : "обновить ивент"
    }

    init(type: BuildEventType, event: Event?) {
        self.type = type
        self.event = event
    }

}
