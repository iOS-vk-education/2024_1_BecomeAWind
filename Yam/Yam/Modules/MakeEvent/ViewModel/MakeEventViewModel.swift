import _PhotosUI_SwiftUI
import SwiftUI
import MapKit

final class MakeEventViewModel: NSObject, ObservableObject, MKMapViewDelegate {

    enum TypeOfMakeEventView {
        case createEvent
        case editEvent
    }

    private var model = MakeEventModel()
    let typeOfMakeEventView: TypeOfMakeEventView
    var event: Event?

    init(
        typeOfMakeEventView: TypeOfMakeEventView = .createEvent,
        event: Event? = nil
    ) {
        self.typeOfMakeEventView = typeOfMakeEventView
        self.event = event

        /// constants declaration
        headerText =
        typeOfMakeEventView == .createEvent
        ? "новый ивент"
        : "редактирование ивента"

        image = typeOfMakeEventView == .createEvent
        ? UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
        : event?.image ?? UIImage(systemName: "photo.artframe")!

        imagePickerButtonText =
        typeOfMakeEventView == .createEvent
        ? "выбери превью"
        : "измени превью"

        eventTitle =
        typeOfMakeEventView == .createEvent
        ? ""
        : event?.title ?? ""

        allSeats =
        typeOfMakeEventView == .createEvent
        ? "1"
        : String(event?.seats.all ?? 1)

        link =
        typeOfMakeEventView == .createEvent
        ? ""
        : event?.link ?? ""

        date = typeOfMakeEventView == .createEvent
        ? Date()
        : event?.date ?? Date()

        placeDescription = typeOfMakeEventView == .createEvent
        ? MakeEventConst.emptyPlaceText
        : event?.place.placeDescription ?? MakeEventConst.emptyPlaceText

        location = typeOfMakeEventView == .createEvent
        ? nil
        : event?.place.location ?? nil

        footerButtonText = typeOfMakeEventView == .createEvent
        ? "создать ивент"
        : "обновить ивент"
    }

    /// header
    let headerText: String

    /// image picker
    @Published private(set) var image: UIImage
    @Published var photosPickerItem: PhotosPickerItem?
    let imagePickerButtonText: String

    /// text fields
    @Published var eventTitle: String
    @Published var allSeats: String
    @Published var link: String

    /// date picker
    @Published var date: Date

    /// place picker
    @Published var isActiveMakeEventPlace = false
    @Published private(set) var centerCoordinate: CLLocationCoordinate2D?
    @Published var placeDescription: String
    private var location: CLLocation?
    private var place: Place?

    /// handle event
    @Published var eventCreationFailed = false
    @Published var eventEditionFailed = false
    let footerButtonText: String

}

/// handle event
extension MakeEventViewModel {

    func handleEvent() -> Bool {
        var result: Bool

        if typeOfMakeEventView == .createEvent {
            result = createEvent()
        } else {
            result = editEvent()
        }

        return result
    }

    func toggleEventHandlingFailed() {
        typeOfMakeEventView == .createEvent
        ? eventCreationFailed.toggle()
        : eventEditionFailed.toggle()
    }
    
}

/// create event
extension MakeEventViewModel {

    private func createEvent() -> Bool {
        let canCreateEvent = validateEventCreation()

        if canCreateEvent {
            let seats = Seats(busy: 0, all: Int(allSeats) ?? 1)
            let place = Place(location: location ?? CLLocation(), placeDescription: placeDescription)
            let event = Event(
                image: image,
                title: eventTitle,
                seats: seats,
                link: link,
                date: date,
                place: place
            )
            model.createEvent(event)
        }

        return canCreateEvent
    }

    private func validateEventCreation() -> Bool {
        var result = false

        if !eventTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            placeDescription != MakeEventConst.emptyPlaceText &&
            location != nil {
            result = true
        }

        return result
    }

}

/// edit event
extension MakeEventViewModel {

    private func editEvent() -> Bool {
        let canEditEvent = validateEventEdition()

        if canEditEvent {
            let seats = Seats(busy: 0, all: Int(allSeats) ?? 1)
            let place = Place(location: location ?? CLLocation(), placeDescription: placeDescription)

            event?.image = image
            event?.title = eventTitle
            event?.seats = seats
            event?.link = link
            event?.date = date
            event?.place = place

            model.editEvent(event)
        }

        return canEditEvent
    }

    private func validateEventEdition() -> Bool {
        var result = false
        let oldAllSeats = event?.seats.all ?? 1

        if !eventTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            Int(allSeats) ?? 1 >= oldAllSeats &&
            placeDescription != MakeEventConst.emptyPlaceText &&
            location != nil {
            result = true
        }

        return result
    }

}

/// image picker
extension MakeEventViewModel {

    func setImage() {
        Task {
            if let photosPickerItem,
               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                if let image = UIImage(data: data) {
                    self.image = image
                }
            }
            photosPickerItem = nil
        }
    }
    
}

/// text field
extension MakeEventViewModel {

    func limitTextField(_ upper: Int, text: Binding<String>) {
        if text.wrappedValue.count > upper {
            text.wrappedValue = String(text.wrappedValue.prefix(upper))
        }
    }

    func filterSeats(_ newValue: String) {
        allSeats = newValue.filter { allSeats.first != "0" && $0.isNumber }
    }

}

/// place picker
extension MakeEventViewModel {

    // conformance to MKMapViewDelegate
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            self.centerCoordinate = mapView.centerCoordinate
        }
    }

    func toggleMakeEventPlace() {
        isActiveMakeEventPlace.toggle()
    }

}

/// location handler
extension MakeEventViewModel {

    func updatePlaceDescription(completion: @escaping (Bool) -> Void) {
        guard let coordinate = centerCoordinate else { return }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        LocationHandler.getPlacemark(from: location) { [weak self] placemark in
            if let placemark {
                let description = LocationHandler.parsePlacemark(placemark)
                self?.placeDescription = description
                self?.location = location
                completion(true)
            } else {
                self?.placeDescription = MakeEventConst.emptyPlaceText
                self?.location = nil
                completion(false)
            }
        }
    }

}
