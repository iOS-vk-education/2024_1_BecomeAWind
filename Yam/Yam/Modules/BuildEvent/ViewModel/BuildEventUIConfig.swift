import SwiftUI
import CoreLocation

struct BuildEventUIConfig {

    let type: TypeOfBuildEventView
    var event: UIEvent?

    var headerText: String {
        type == .create ? "новый ивент" : "редактирование ивента"
    }

    var image: UIImage {
        type == .create
        ? UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
        : event?.image ?? UIImage(systemName: "photo.artframe")!
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
        : event?.place.placeDescription ?? BuildEventConst.emptyPlaceText
    }

    var location: CLLocation? {
        type == .create ? nil : event?.place.location ?? nil
    }

    var footerButtonText: String {
        type == .create ? "создать ивент" : "обновить ивент"
    }

    init(type: TypeOfBuildEventView, event: UIEvent?) {
        self.type = type
        self.event = event
    }

}
