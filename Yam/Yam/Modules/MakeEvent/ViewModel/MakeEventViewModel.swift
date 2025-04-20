import _PhotosUI_SwiftUI
import SwiftUI
import MapKit
import FirebaseFirestore

final class MakeEventViewModel: NSObject, ObservableObject, MKMapViewDelegate {

    private var model = MakeEventModel()
    private let imageService = ImageService.shared
    let typeOfMakeEventView: TypeOfMakeEventView
    var uievent: UIEvent?

    /// header
    var headerText: String = ""

    /// image picker
    @Published private(set) var image: UIImage = UIImage()
    @Published var photosPickerItem: PhotosPickerItem?
    var imagePickerButtonText = ""

    /// text fields
    @Published var eventTitle = ""
    @Published var allSeats = ""
    @Published var link = ""

    /// date picker
    @Published var date = Date()

    /// place picker
    @Published var isActiveMakeEventPlace = false
    @Published private(set) var centerCoordinate: CLLocationCoordinate2D?
    @Published var placeDescription = ""
    private var location: CLLocation?
    private var place: Place?

    /// handle event
    @Published var isCreatingEvent = false
    @Published var eventCreationFailed = false
    @Published var eventEditionFailed = false
    var footerButtonText: String = ""

    init(
        typeOfMakeEventView: TypeOfMakeEventView = .create,
        event: UIEvent? = nil
    ) {
        self.typeOfMakeEventView = typeOfMakeEventView
        self.uievent = event
        super.init()

        initConstants()
    }

}

// MARK: - Init
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
        : uievent?.image ?? UIImage(systemName: "photo.artframe")!
    }

    private func initImagePicker() {
        imagePickerButtonText = typeOfMakeEventView == .create ? "выбери превью" : "измени превью"
    }

    private func initEventTitle() {
        eventTitle = typeOfMakeEventView == .create ? "" : uievent?.title ?? ""
    }

    private func initAllSeats() {
        allSeats = typeOfMakeEventView == .create ? "1" : String(uievent?.seats.all ?? 1)
    }

    private func initLink() {
        link = typeOfMakeEventView == .create ? "" : uievent?.link ?? ""
    }

    private func initDate() {
        date = typeOfMakeEventView == .create ? Date() : uievent?.date ?? Date()
    }

    private func initPlaceDescription() {
        placeDescription = typeOfMakeEventView == .create
        ? MakeEventConst.emptyPlaceText
        : uievent?.place.placeDescription ?? MakeEventConst.emptyPlaceText
    }

    private func initLocation() {
        location = typeOfMakeEventView == .create ? nil : uievent?.place.location ?? nil
    }

    private func initFooterButtonText() {
        footerButtonText = typeOfMakeEventView == .create ? "создать ивент" : "обновить ивент"
    }

}

// MARK: - Handle event
extension MakeEventViewModel {

    func handleEvent() async -> Bool {
        await MainActor.run { isCreatingEvent = true }
        defer {
            Task { @MainActor in
                isCreatingEvent = false
            }
        }

        var result: Bool

        if typeOfMakeEventView == .create {
            result = await createEvent()
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

// MARK: - Create event
extension MakeEventViewModel {

    private func createEvent() async -> Bool {
        let canCreateEvent = validateEventCreation()

        if canCreateEvent {
            guard let url = await getImageUrl() else {
                return false
            }

            let seats = Seats(busy: 0, all: Int(allSeats) ?? 1)
            let place = GeoPoint(
                latitude: location?.coordinate.latitude ?? 0.0,
                longitude: location?.coordinate.latitude ?? 0.0
            )

            let event = Event(
                imageUrl: url,
                title: eventTitle,
                seats: seats,
                link: link,
                date: date,
                place: place
            )
            model.create(event: event)
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

    private func getImageUrl() async -> String? {
        do {
            let url = try await imageService.uploadImage(image: image)
            return url
        } catch {
            Logger.MakeEvent.imageUploadFail()
            return nil
        }
    }

}

// MARK: - Edit event
extension MakeEventViewModel {

    private func editEvent() -> Bool {
        let canEditEvent = validateEventEdition()

        if canEditEvent {
            let seats = Seats(busy: 0, all: Int(allSeats) ?? 1)
            let place = Place(location: location ?? CLLocation(), placeDescription: placeDescription)

            uievent?.image = image
            uievent?.title = eventTitle
            uievent?.seats = seats
            uievent?.link = link
            uievent?.date = date
            uievent?.place = place

            model.edit(uievent)
        }

        return canEditEvent
    }

    private func validateEventEdition() -> Bool {
        var result = false
        let oldAllSeats = uievent?.seats.all ?? 1

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

// MARK: - Image picker
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

// MARK: - Text field
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

// MARK: - Place picker
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

// MARK: - Location handler
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
