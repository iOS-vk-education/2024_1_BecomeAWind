import _PhotosUI_SwiftUI
import SwiftUI
import MapKit

final class MakeEventViewModel: NSObject, ObservableObject, MKMapViewDelegate {

    enum TypeOfMakeEventView {
        case create
        case edit
    }

    private var model = MakeEventModel()
    let typeOfMakeEventView: TypeOfMakeEventView
    var event: UIEvent?

    init(
        typeOfMakeEventView: TypeOfMakeEventView = .create,
        event: UIEvent? = nil
    ) {
        self.typeOfMakeEventView = typeOfMakeEventView
        self.event = event
        super.init()

        initConstants()
    }

    /// header
    var headerText: String = ""

    /// image picker
    @Published private(set) var image: UIImage = UIImage()
    @Published var photosPickerItem: PhotosPickerItem?
    var imagePickerButtonText: String = ""

    /// text fields
    @Published var eventTitle: String = ""
    @Published var allSeats: String = ""
    @Published var link: String = ""

    /// date picker
    @Published var date: Date = Date()

    /// place picker
    @Published var isActiveMakeEventPlace = false
    @Published private(set) var centerCoordinate: CLLocationCoordinate2D?
    @Published var placeDescription: String = ""
    private var location: CLLocation?
    private var place: Place?

    /// handle event
    @Published var eventCreationFailed = false
    @Published var eventEditionFailed = false
    var footerButtonText: String = ""

}

// MARK: - init
extension MakeEventViewModel {

    private func initConstants() {
        initHeaderText()
        initImage()
        initImagePicker()
        initEventTitle()
        initAllSeats()
        initLink()
        initDate()
        initPlaceDescription()
        initLocation()
        initFooterButtonText()
    }

    private func initHeaderText() {
        headerText = typeOfMakeEventView == .create ? "новый ивент" : "редактирование ивента"
    }

    private func initImage() {
        image = typeOfMakeEventView == .create
        ? UIImage(named: "default_event_image") ?? UIImage(systemName: "photo.artframe")!
        : event?.image ?? UIImage(systemName: "photo.artframe")!
    }

    private func initImagePicker() {
        imagePickerButtonText = typeOfMakeEventView == .create ? "выбери превью" : "измени превью"
    }

    private func initEventTitle() {
        eventTitle = typeOfMakeEventView == .create ? "" : event?.title ?? ""
    }

    private func initAllSeats() {
        allSeats = typeOfMakeEventView == .create ? "1" : String(event?.seats.all ?? 1)
    }

    private func initLink() {
        link = typeOfMakeEventView == .create ? "" : event?.link ?? ""
    }

    private func initDate() {
        date = typeOfMakeEventView == .create ? Date() : event?.date ?? Date()
    }

    private func initPlaceDescription() {
        placeDescription = typeOfMakeEventView == .create
        ? MakeEventConst.emptyPlaceText
        : event?.place.placeDescription ?? MakeEventConst.emptyPlaceText
    }

    private func initLocation() {
        location = typeOfMakeEventView == .create ? nil : event?.place.location ?? nil
    }

    private func initFooterButtonText() {
        footerButtonText = typeOfMakeEventView == .create ? "создать ивент" : "обновить ивент"
    }

}

// MARK: - handle event
extension MakeEventViewModel {

    func handleEvent() -> Bool {
        var result: Bool

        if typeOfMakeEventView == .create {
            result = createEvent()
        } else {
            result = editEvent()
        }

        return result
    }

    func toggleEventHandlingFailed() {
        typeOfMakeEventView == .create
        ? eventCreationFailed.toggle()
        : eventEditionFailed.toggle()
    }
    
}

// MARK: - create event
extension MakeEventViewModel {

    private func createEvent() -> Bool {
        let canCreateEvent = validateEventCreation()

        if canCreateEvent {
            let seats = Seats(busy: 0, all: Int(allSeats) ?? 1)
            let place = Place(location: location ?? CLLocation(), placeDescription: placeDescription)
            let event = UIEvent(
                image: image,
                title: eventTitle,
                seats: seats,
                link: link,
                date: date,
                place: place
            )
            model.create(event)
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

// MARK: - edit event
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

            model.edit(event)
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

// MARK: - image picker
extension MakeEventViewModel {

    func setImage() {
        Task {
            if let photosPickerItem,
               let data = try? await photosPickerItem.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                self.image = image
            }
            photosPickerItem = nil
        }
    }

}

// MARK: - text field
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

// MARK: - place picker
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

// MARK: - location handler
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
